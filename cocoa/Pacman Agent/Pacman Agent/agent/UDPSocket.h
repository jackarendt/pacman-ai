#import <Foundation/Foundation.h>

@interface UDPSocket : NSObject

- (instancetype)initWithPort:(uint16_t)port;

- (BOOL)sendData:(NSData *)data;

@end
