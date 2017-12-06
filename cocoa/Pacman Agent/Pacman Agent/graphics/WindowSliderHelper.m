#import "WindowSliderHelper.h"

const int kPixelSampleCount = 4;

/** Fills the pixel buffer for a tile.
 *  @param buffer Populates the buffer that is supplied with the pixel data.
 *  @param x The x coordinate of the tile.
 *  @param y The y coordinate of the tile.
 *  @param bitmap The pixel data for the entire image.
 *  @param imageWidth The width of the entire image.
 */
void FillPixelBuffer(unsigned char *buffer,
                     int x,
                     int y,
                     const unsigned char *bitmap,
                     CGSize tileSize,
                     int imageWidth) {
  
  int bufferRowMax = kPixelSampleCount * (int)tileSize.width;
  int imageRowMax = kPixelSampleCount * imageWidth;
  
  int width = (int)tileSize.width;
  int height = (int)tileSize.height;
  
  // The image is populated [a, r, g, b, a, r, g, b] moving from (0, 0) to (n, 0) then over each row
  // until it hits (n, m). This populates the tile buffer with the correct pixel values.
  for (int i = 0; i < height; i++) {
    for (int j = 0; j < width; j++) {
      for (int k = 0; k < kPixelSampleCount; k++) {
        // Calculate the manhattan distance that the pixel is from the image origin.
        int yDistance = (y * width + i) * imageRowMax;
        int xDistance = (x * width + j) * kPixelSampleCount;
        unsigned char value = bitmap[yDistance + xDistance + k];
        buffer[i * bufferRowMax + j * kPixelSampleCount + k] = value;
      }
    }
  }
}

void TileBitmap(NSBitmapImageRep *bitmap,
                CGSize tileSize,
                void (^callback)(unsigned char *, int, int, int)) {
  unsigned char *bitmapData = bitmap.bitmapData;
  int width = (int)bitmap.pixelsWide;
  
  // Get the number of tiles for each axis.
  int xTiles = floor(bitmap.pixelsWide / tileSize.width);
  int yTiles = floor(bitmap.pixelsHigh / tileSize.height);
  
  
  // Iterate over tiles, moving row by row.
  for (int i = 0; i < yTiles; i++) {
    for (int j = 0; j < xTiles; j++) {
      // Create a buffer for the tile's pixel data.
      // bufferSize = width * height * samples per pixel.
      int bufferSize = (int)tileSize.width * (int)tileSize.height * kPixelSampleCount;
      unsigned char *buffer = malloc(bufferSize * sizeof(unsigned char));
      
      // Fill the pixel buffer and invoke the callback block.
      FillPixelBuffer(buffer, j, i, bitmapData, tileSize, width);
      callback(buffer, j, i, bufferSize);
    }
  }
}
