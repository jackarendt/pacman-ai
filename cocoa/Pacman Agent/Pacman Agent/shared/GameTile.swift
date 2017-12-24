import Foundation

class GameTile: CustomStringConvertible {
  /// The position of the game tile.
  let position: CGPoint
  /// The center pixel coordinate of the tile.
  var centerPixelCoordinate = CGPoint.zero
  /// The type of game piece.
  var piece: TileType = .unknown
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
    pixels.deallocate(capacity: bufferLength)
  }
  
  /// Returns an image representation of the tile.
  func bitmap() -> NSBitmapImageRep? {
    guard bufferLength > 0 else {
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
        pixelBuffer.deallocate(capacity: kSamplesPerPixel)
      }
    }
    return bm
  }
  
  /// Saves a bitmap to the specified directory.
  /// Returns the filename of the bitmap.
  func saveBitmap(directory: String, hashedFilename: Bool=false) -> String {
    var filename = "\(Int(position.x))_\(Int(position.y))"
    
    if (hashedFilename) {
      filename = abs((filename + Date().description + arc4random().description).hash).description
    }
    
    let fullPath = directory + filename + ".tiff"
    let _ = bitmap()?.saveToPath(path: fullPath)
    return filename
  }
  
  var description: String {
    return "x: \(position.x), y: \(position.y)\n\(TileMatcher.description(for: piece))"
  }
}
