import Foundation

class GameTile: CustomStringConvertible {
  /// The position of the game tile.
  let position: CGPoint
  /// The center pixel coordinate of the tile.
  var centerPixelCoordinate = CGPoint.zero
  /// The type of game piece.
  var piece: TileType = .unknown
  /// The character of the tile, if it is a text tile.
  var character: String = " "
  /// The pixels that make up the image. They are organized as [a, r, g, b, a, r, g, b....], and
  /// move horizontally across the image before moving to the next row.
  let pixels: UnsafeMutablePointer<PixelComponent>
  /// The length of the buffer.
  let bufferLength: Int
  
  init(position: CGPoint, pixels: UnsafeMutablePointer<PixelComponent>, bufferLength: Int) {
    self.position = position
    self.pixels = pixels
    self.bufferLength = bufferLength
  }
  
  deinit {
    pixels.deallocate()
  }
  
  /// Returns an image representation of the tile.
  func bitmap() -> NSBitmapImageRep? {
    // Make sure there is an image buffer, and the first value (alpha) is 255. Don't save partially
    // visible tiles.
    guard bufferLength > 0 && pixels[0] == 255 else {
      return nil
    }
    
    // Create an bitmap image representation of the tile.
    let dimensions = Int(sqrt(Double(bufferLength / kSamplesPerPixel)))
    let bitmapImageRep = NSBitmapImageRep(bitmapDataPlanes: nil,
                                          pixelsWide: dimensions,
                                          pixelsHigh: dimensions,
                                          bitsPerSample: 8,
                                          samplesPerPixel: kSamplesPerPixel,
                                          hasAlpha: true,
                                          isPlanar: true,
                                          colorSpaceName: .deviceRGB,
                                          bitmapFormat: .alphaFirst,
                                          bytesPerRow: 8,
                                          bitsPerPixel: 8)
    
    guard let bm = bitmapImageRep else {
      return nil
    }
    
    /// Copy bitmap data to the new image's pixel data.
    let rowLength = Int(kGameTileSize.width) * kSamplesPerPixel
    for i in 0..<dimensions {
      for j in 0..<dimensions {
        let pixelBuffer = UnsafeMutablePointer<Int>.allocate(capacity: kSamplesPerPixel)
        for k in 0..<kSamplesPerPixel {
          pixelBuffer[k] = Int(pixels[i * rowLength + j * kSamplesPerPixel + k])
        }
        bm.setPixel(pixelBuffer, atX: j, y: i)
        pixelBuffer.deallocate()
      }
    }
    return bm
  }
  
  var description: String {
    return "x: \(position.x), y: \(position.y)\n\(TileModel.description(for: piece))"
  }
}
