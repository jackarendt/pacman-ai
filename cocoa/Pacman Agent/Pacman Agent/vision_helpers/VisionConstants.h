#import <Foundation/Foundation.h>

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
