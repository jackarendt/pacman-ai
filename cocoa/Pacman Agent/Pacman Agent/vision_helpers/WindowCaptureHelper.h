#import <AppKit/AppKit.h>

extern NSString const *kAppNameKey;
extern NSString const *kWindowIDKey;
extern NSString const *kWindowNameKey;
extern NSString const *kApplicationPIDKey;

/** Captures all of the current windows and their associated metadata. */
NSArray<NSDictionary<NSString *, id> *> *CaptureWindowMetadata(void);

/** Captures a window, and returns an image that is ready to be displayed. */
NSImage *CaptureWindowForWindowID(CGWindowID windowID);
