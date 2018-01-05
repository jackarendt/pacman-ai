#import <Foundation/Foundation.h>

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

/** Typedef for what type each pixel component is stored as. */
typedef float PixelComponent;

/** The size of each tile. */
extern const CGSize kGameTileSize;

/** The number of samples per pixel. */
extern const NSInteger kSamplesPerPixel;

/** The number of horizontal game tiles. */
extern const NSInteger kGameTileWidth;

/** The number of vertical game tiles. */
extern const NSInteger kGameTileHeight;

/** Array of valid OCR characters. [A-Z, 0-9] */
extern const NSArray<NSString *> *kOCRValidCharacters;
