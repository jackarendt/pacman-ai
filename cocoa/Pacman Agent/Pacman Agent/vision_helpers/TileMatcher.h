#import <Foundation/Foundation.h>
#import "VisionConstants.h"

/** Enumeration of all of the different tile types. */
typedef NS_ENUM(NSInteger, TileType) {
  /** Unknown Tile. */
  TileTypeUnknown = 0,
  /** Contains a majority of pacman. */
  TileTypePacman = 1,
  /** Contains a wall. */
  TileTypeWall = 2,
  /** Empty tile. */
  TileTypeBlank = 3,
  /** Fruit. i.e. Cherry, Apple, etc. */
  TileTypeFruit = 4,
  /** Blinky, not frightened. */
  TileTypeBlinky = 5,
  /** Inky, not frightened. */
  TileTypeInky = 6,
  /** Pinky, not frightened. */
  TileTypePinky = 7,
  /** Clyde, not frightened. */
  TileTypeClyde = 8,
  /** Any frightened ghost. */
  TileTypeFrightenedGhost = 9,
  /** Regular pellet. */
  TileTypePellet = 10,
  /** Power pellet. Causes ghosts to be frightened. */
  TileTypePowerPellet = 11,
  /** Text of any kind. */
  TileTypeText = 12,
  /** Not important tile. */
  TileTypeIgnore = 13,
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
