#import <Foundation/Foundation.h>
#import "VisionConstants.h"

/** Enumeration of all of the different tile types. */
typedef NS_ENUM(NSInteger, TileType) {
  /** Unknown Tile. */
  TileTypeUnknown = -1,
  /** Contains a majority of pacman. */
  TileTypePacman = 0,
  /** Contains a wall. */
  TileTypeWall = 1,
  /** Empty tile. */
  TileTypeBlank = 2,
  /** Fruit. i.e. Cherry, Apple, etc. */
  TileTypeFruit = 3,
  /** Blinky, not frightened. */
  TileTypeBlinky = 4,
  /** Inky, not frightened. */
  TileTypeInky = 5,
  /** Pinky, not frightened. */
  TileTypePinky = 6,
  /** Clyde, not frightened. */
  TileTypeClyde = 7,
  /** Any frightened ghost. */
  TileTypeFrightenedGhost = 8,
  /** Regular pellet. */
  TileTypePellet = 9,
  /** Power pellet. Causes ghosts to be frightened. */
  TileTypePowerPellet = 10,
  /** Text of any kind. */
  TileTypeText = 11,
  /** Not important tile. */
  TileTypeIgnore = 12,
};

/** Matches a bitmap image with a tile type. */
@interface TileMatcher : NSObject

/** Loads the vision model and creates a new tensorflow session. Will return NO and print an error
 *  to the console if the loading fails.
 */
- (BOOL)loadVisionModel;

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
