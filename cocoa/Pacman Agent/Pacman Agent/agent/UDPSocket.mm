#import "UDPSocket.h"

#import <CoreFoundation/CoreFoundation.h>
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
    _socketout = CFSocketCreate(kCFAllocatorDefault, PF_INET, SOCK_DGRAM, IPPROTO_UDP,
                                kCFSocketDataCallBack, dataCallback, NULL);
    
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
  if (!_socketout) {
    NSLog(@"No open socket.");
    return NO;
  }
  
  // Create the address data and message data
  CFDataRef addr_data = CFDataCreate(NULL, (const uint8_t *)&_addr, sizeof(_addr));
  CFDataRef msg_data = CFDataCreate(NULL, (const uint8_t *)data.bytes, data.length);
  CFSocketError retval = CFSocketSendData(_socketout, addr_data, msg_data, 0);
  
  CFRelease(addr_data);
  CFRelease(msg_data);
  
  return retval == kCFSocketSuccess;
}

static void dataCallback(CFSocketRef s,
                         CFSocketCallBackType type,
                         CFDataRef addr,
                         const void *data,
                         void *info) {
  CFDataRef dataRef = (CFDataRef)data;
  NSLog(@"data recevied: (%s)", CFDataGetBytePtr(dataRef));
}

@end
