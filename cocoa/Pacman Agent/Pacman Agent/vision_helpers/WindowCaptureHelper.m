#import "WindowCaptureHelper.h"

NSString const *kAppNameKey = @"kApplicationName";  // Application Name & PID
NSString const *kWindowIDKey = @"kWindowID";  // Window ID.
NSString const *kWindowNameKey = @"kWindowName"; // Name of the window.
NSString const *kApplicationPIDKey = @"kApplicationPID"; // PID of the window owner

/** Filters the full metadata dictionary, and converts it from a CFDictionary to NSDictionary. */
void WindowListApplierFunction(const void *inputDictionary, void *context);
void WindowListApplierFunction(const void *inputDictionary, void *context) {
  CFDictionaryRef input = (CFDictionaryRef)inputDictionary;
  NSMutableArray<NSDictionary *> *data = (__bridge NSMutableArray *)context;
  
  NSMutableDictionary *filteredMetadata = [NSMutableDictionary dictionary];
  NSString *applicationName = CFDictionaryGetValue(input, kCGWindowOwnerName);
  if (applicationName.length > 0) {
    filteredMetadata[kAppNameKey] = applicationName;
  }
  
  NSNumber *windowID = CFDictionaryGetValue(input, kCGWindowNumber);
  if (windowID.intValue > 0) {
    filteredMetadata[kWindowIDKey] = windowID;
  }
  
  NSString *windowName = CFDictionaryGetValue(input, kCGWindowName);
  if (windowName.length > 0) {
    filteredMetadata[kWindowNameKey] = windowName;
  }
  
  NSNumber *applicationPID = CFDictionaryGetValue(input, kCGWindowOwnerPID);
  if (applicationPID.intValue > 0) {
    filteredMetadata[kApplicationPIDKey] = applicationPID;
  }
  
  [data addObject:[filteredMetadata copy]];
}

NSArray<NSDictionary<NSString *, id> *> *CaptureWindowMetadata() {
  // Get the window list.
  CGWindowListOption options =
      kCGWindowListOptionOnScreenOnly | kCGWindowListExcludeDesktopElements;
  CFArrayRef windowList = CGWindowListCopyWindowInfo(options, kCGNullWindowID);
  
  // Create an array that will return the swift-friendly window list.
  CFIndex windowCount = CFArrayGetCount(windowList);
  NSMutableArray<NSDictionary<NSString *, id> *> *windows =
      [NSMutableArray arrayWithCapacity:windowCount];
  
  // Iterate over the array to filter the total metadata to the ones that we want.
  CFArrayApplyFunction(windowList,
                       CFRangeMake(0, windowCount),
                       &WindowListApplierFunction,
                       (void *)windows);
  CFRelease(windowList);
  return [windows copy];
}

NSImage *CaptureWindowForWindowID(CGWindowID windowID) {
  CGImageRef windowImage = CGWindowListCreateImage(CGRectNull,
                                                   kCGWindowListOptionIncludingWindow,
                                                   windowID,
                                                   kCGWindowImageBoundsIgnoreFraming);
  
  if (windowImage == NULL) {
    return nil;
  }
  
  NSBitmapImageRep *bitmap = [[NSBitmapImageRep alloc] initWithCGImage:windowImage];
  NSImage *image = [[NSImage alloc] init];
  [image addRepresentation:bitmap];
  
  CGImageRelease(windowImage);
  return image;
}

