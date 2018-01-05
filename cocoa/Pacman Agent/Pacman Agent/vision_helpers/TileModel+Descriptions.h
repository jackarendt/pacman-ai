#import "TileModel.h"

/** The number of tile types. */
extern const NSInteger kTileTypeCount;

@interface TileModel (Descriptions)

/** Returns the description of a tile type. */
+ (NSString *)descriptionForTileType:(enum TileType)tileType;

/** Populates a buffer with all of the different tile types. */
+ (void)allTileTypes:(enum TileType *)typeBuffer;

/** Returns a single character describing the tile. */
+ (NSString *)characterForTileType:(enum TileType)tileType;

@end
