import Foundation

class GameTile: CustomStringConvertible {
  /// The position of the game tile.
  let position: CGPoint
  /// The center pixel coordinate of the tile.
  var centerPixelCoordinate = CGPoint.zero
  /// The type of game piece.
  var piece: GamePiece = .unknown
  /// The pixels that make up the image. They are organized as [a, r, g, b, a, r, g, b....], and
  /// move horizontally across the image before moving to the next row.
  let pixels: UnsafeMutablePointer<UInt8>
  /// The length of the buffer.
  let bufferLength: Int
  
  init(position: CGPoint, pixels: UnsafeMutablePointer<UInt8>, bufferLength: Int) {
    self.position = position
    self.pixels = pixels
    self.bufferLength = bufferLength
  }
  
  deinit {
    pixels.deallocate(capacity: bufferLength)
  }
  
  /// Returns an image representation of the tile.
  func image() -> NSImage {
    guard bufferLength > 0 else {
      return NSImage()
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
    
    /// Copy bitmap data to the new image's pixel data.
    let image = NSImage(size: kGameTileSize)
    if let bitmap = bitmapImageRep {
      let rowLength = Int(kGameTileSize.width) * kSamplesPerPixel
      for i in 0..<dimensions {
        for j in 0..<dimensions {
          let pixelBuffer = UnsafeMutablePointer<Int>.allocate(capacity: kSamplesPerPixel)
          for k in 0..<kSamplesPerPixel {
            pixelBuffer[k] = Int(pixels[i * rowLength + j * kSamplesPerPixel + k])
          }
          bitmap.setPixel(pixelBuffer, atX: j, y: i)
          pixelBuffer.deallocate(capacity: kSamplesPerPixel)
        }
      }
      image.addRepresentation(bitmap)
    }
    
    return image
  }
  
  var description: String {
    return "x: \(position.x), y: \(position.y)\n\(piece.description)"
  }
}
