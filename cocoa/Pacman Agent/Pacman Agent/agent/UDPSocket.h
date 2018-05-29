#import <Foundation/Foundation.h>

@class UDPSocket;

@protocol UDPSocketDelegate <NSObject>

/** Invoked when the socket is sent back data. */
- (void)socket:(UDPSocket *)socket didReturnData:(NSData *)data;

@end

/** A simple client interface for working with a UDP socket. */
@interface UDPSocket : NSObject

/** Delegate for responding to socket events. */
@property(nonatomic, weak) id<UDPSocketDelegate> delegate;

/** Port that is used to connect with an accompanying socket. */
@property(nonatomic, readonly) uint16_t port;

/** Returns whether or not the socket is active. */
@property(nonatomic, readonly) BOOL isActive;

- (instancetype)initWithPort:(uint16_t)port;

/** Sends data to the server. Returns YES on success. */
- (BOOL)sendData:(NSData *)data;

@end
