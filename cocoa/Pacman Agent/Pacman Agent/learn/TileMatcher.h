#import <Foundation/Foundation.h>

/** The number of tile types. */
extern const NSInteger kTileTypeCount;

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
};

/** Matches a bitmap image with a tile type. */
@interface TileMatcher : NSObject

/** Returns the description of a tile type. */
+ (NSString *)descriptionForTileType:(enum TileType)tileType;

/** Populates a buffer with all of the different tile types. */
+ (void)allTileTypes:(enum TileType *)typeBuffer;

@end
