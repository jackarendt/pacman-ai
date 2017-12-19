#import "WindowSliderHelper.h"

/** Fills the pixel buffer for a tile.
 *  @param buffer Populates the buffer that is supplied with the pixel data.
 *  @param x The x coordinate of the tile.
 *  @param y The y coordinate of the tile.
 *  @param bitmap The pixel data for the entire image.
 *  @param imageWidth The width of the entire image.
 */
void FillPixelBuffer(PixelComponent *buffer,
                     NSInteger x,
                     NSInteger y,
                     const unsigned char *bitmap,
                     CGSize tileSize,
                     NSInteger imageWidth) {
  
  NSInteger bufferRowMax = kSamplesPerPixel * (NSInteger)tileSize.width;
  NSInteger imageRowMax = kSamplesPerPixel * imageWidth;
  
  int width = (int)tileSize.width;
  int height = (int)tileSize.height;
  
  // The image is populated [a, r, g, b, a, r, g, b] moving from (0, 0) to (n, 0) then over each row
  // until it hits (n, m). This populates the tile buffer with the correct pixel values.
  for (NSInteger i = 0; i < height; i++) {
    for (NSInteger j = 0; j < width; j++) {
      for (NSInteger k = 0; k < kSamplesPerPixel; k++) {
        // Calculate the manhattan distance that the pixel is from the image origin.
        NSInteger yDistance = (y * width + i) * imageRowMax;
        NSInteger xDistance = (x * width + j) * kSamplesPerPixel;
        unsigned char value = bitmap[yDistance + xDistance + k];
        buffer[i * bufferRowMax + j * kSamplesPerPixel + k] = (PixelComponent)value;
      }
    }
  }
}

void TileBitmap(NSBitmapImageRep *bitmap,
                CGSize tileSize,
                void (^callback)(PixelComponent *, NSInteger, NSInteger, NSInteger)) {
  unsigned char *bitmapData = bitmap.bitmapData;
  NSInteger width = bitmap.pixelsWide;
  
  // Get the number of tiles for each axis.
  int xTiles = floor(bitmap.pixelsWide / tileSize.width);
  int yTiles = floor(bitmap.pixelsHigh / tileSize.height);
  
  
  // Iterate over tiles, moving row by row.
  for (NSInteger i = 0; i < yTiles; i++) {
    for (NSInteger j = 0; j < xTiles; j++) {
      // Create a buffer for the tile's pixel data.
      // bufferSize = width * height * samples per pixel.
      NSInteger bufferSize =
          (NSInteger)tileSize.width * (NSInteger)tileSize.height * kSamplesPerPixel;
      PixelComponent *buffer = malloc(bufferSize * sizeof(PixelComponent));
      
      // Fill the pixel buffer and invoke the callback block.
      FillPixelBuffer(buffer, j, i, bitmapData, tileSize, width);
      callback(buffer, j, i, bufferSize);
    }
  }
}
