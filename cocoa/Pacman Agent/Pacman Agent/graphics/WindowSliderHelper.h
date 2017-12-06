#import <AppKit/AppKit.h>

/** Slides across an image given by the size of the tile, and invokes a callback block after each
 *  tile is captured.
 *  @param bitmap a 1D array of pixel values.
 *  @param tileSize The size of a tile.
 *  @param callback The callback block that is invoked when a tile is captured.
 */
void TileBitmap(NSBitmapImageRep *bitmap,
                CGSize tileSize,
                void (^callback)(unsigned char *, int, int, int));
