#import "UDPSocket.h"

#import <sys/socket.h>
#import <arpa/inet.h>
#import <netinet/in.h>

@implementation UDPSocket {
  CFSocketRef _socketout;
  struct sockaddr_in _addr;
}

- (instancetype)initWithPort:(uint16_t)port {
  self = [super init];
  if (self) {
    _port = port;
    
    CFSocketContext context = { 0, (__bridge_retained void *)self, NULL, NULL, NULL };
    _socketout = CFSocketCreate(kCFAllocatorDefault, PF_INET, SOCK_DGRAM, IPPROTO_UDP,
                                kCFSocketDataCallBack, dataCallback, &context);
    
    memset(&_addr, 0, sizeof(_addr));
    _addr.sin_len = sizeof(_addr);
    _addr.sin_family = AF_INET;
    _addr.sin_port = htons(port);
    _addr.sin_addr.s_addr = INADDR_ANY;
    
    CFRunLoopSourceRef rls = CFSocketCreateRunLoopSource(kCFAllocatorDefault, _socketout, 0);
    CFRunLoopAddSource(CFRunLoopGetCurrent(), rls, kCFRunLoopCommonModes);
    CFRelease(rls);
  }
  return self;
}

- (BOOL)sendData:(NSData *)data {
  if (!self.isActive) {
    NSLog(@"No open socket.");
    return NO;
  }
  
  // Create the address data and message data.
  CFDataRef addrData = CFDataCreate(NULL, (const uint8_t *)&_addr, sizeof(_addr));
  CFDataRef msgData = CFDataCreate(NULL, (const uint8_t *)data.bytes, data.length);
  CFSocketError retval = CFSocketSendData(_socketout, addrData, msgData, 0);
  
  CFRelease(addrData);
  CFRelease(msgData);
  
  return retval == kCFSocketSuccess;
}

- (BOOL)isActive {
  return _socketout != NULL;
}

- (NSString *)description {
  return [NSString stringWithFormat:@"UDPSocket:%u", _port];
}

static void dataCallback(CFSocketRef s,
                         CFSocketCallBackType type,
                         CFDataRef addr,
                         const void *data,
                         void *info) {
  CFDataRef dataRef = (CFDataRef)data;
  
  // Cast the object to a CoreFoundation type and check the retain count. The CFSocketContext
  // performs a retained bridge which increments the retain count. So a socket that is still active
  // will have a retain count of at least 2. A retain count of 1 or less means only the context is
  // holding a reference to the socket. Release the socket, which should deallocate the socket.
  CFDataRef object = (CFDataRef)info;
  if (CFGetRetainCount(object) < 2) {
    CFRelease(object);
    return;
  }
  
  // Alert the delegate that the socket is updated.
  UDPSocket *context = (__bridge UDPSocket *)info;
  [context.delegate socket:context didReturnData:(__bridge NSData *)dataRef];
}

@end
