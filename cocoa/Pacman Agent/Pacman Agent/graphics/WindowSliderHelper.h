#import <AppKit/AppKit.h>
#import "VisionConstants.h"

/** Slides across an image given by the size of the tile, and invokes a callback block after each
 *  tile is captured.
 *  @param bitmap a 1D array of pixel values.
 *  @param callback The callback block that is invoked when a tile is captured.
 */
void TileBitmap(NSBitmapImageRep *bitmap,
                void (^callback)(PixelComponent *, NSInteger, NSInteger, NSInteger));
