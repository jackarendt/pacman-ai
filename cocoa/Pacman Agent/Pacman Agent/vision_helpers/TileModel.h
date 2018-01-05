#import <Foundation/Foundation.h>
#import "VisionConstants.h"

/** The Tile classification model. Predicts what a set of tiles are given the bitmap data. */
@interface TileModel : NSObject

/** Loads the vision model and creates a new tensorflow session. Will return NO and print an error
 *  to the console if the loading fails.
 */
- (BOOL)loadTileModel;

/** Predicts what type of tile occupies a given space.
 *  @param pixelBuffer This is an array of length NxM where N is the number of tiles to classify,
 *  and M is the length of a single image buffer. Each image should be stored in a 1D array, with
 *  the ARGB pixel format. If an image is 8x8, then it will have 64 pixels total * 4 color
 *  components = 256 * sizeof(uint8_t) in length.
 *  @param tileBuffer This is a buffer that gets populated with the type for each tile. It should be
 *  N * sizeof(NSInteger) long.
 *  @param threshold The confidence threshold that is required to classify a tile as a given type.
 *  If an object does not reach this threshold, it will be classified as TileTypeUnknown.
 */
- (void)predictionsForTiles:(const PixelComponent *)pixelBuffer
                 tileBuffer:(enum TileType *)buffer
        confidenceThreshold:(float)threshold;

@end
