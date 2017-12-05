import Foundation

typealias BitmapPointer = UnsafeMutablePointer<UnsafeMutablePointer<UInt8>?>

struct GameTile: CustomStringConvertible {
  /// The position of the game tile.
  let position: CGPoint
  /// A 1D array of all of the pixel values in that tile.
  let colorBitmap: [[UInt8]]
  
  let colors: [NSColor]
  /// The center pixel coordinate of the tile.
  var centerPixelCoordinate = CGPoint.zero
  /// The type of game piece.
  var piece: GamePiece = .unknown
  
  init(position: CGPoint, colors: [NSColor]) {
    self.position = position
    self.colors = colors
    self.colorBitmap = GameTile.bitmapRepresentation(colors: colors)
  }
  
  // Returns the 1D color array as a 2D array of color components. [[r, g, b], [r, g, b], ....].
  private static func bitmapRepresentation(colors: [NSColor]) -> [[UInt8]] {
    var bitmap = [[UInt8]]()
    bitmap.reserveCapacity(colors.count)
    
    for color in colors {
      let red = UInt8(color.redComponent * 255.0)
      let green = UInt8(color.greenComponent * 255.0)
      let blue = UInt8(color.blueComponent * 255.0)
      let alpha = UInt8(color.alphaComponent * 255.0)
      
      bitmap.append([red, green, blue, alpha])
    }
    return bitmap
  }
  
  /// Returns an image representation of the tile.
  func image() -> NSImage {
    guard colorBitmap.count > 0 else {
      return NSImage()
    }
    
    // Create an bitmap image representation of the tile.
    let dimensions = Int(sqrt(Double(colorBitmap.count)))
//    let bitmapImageRep = NSBitmapImageRep(bitmapDataPlanes: pointer,
//                                          pixelsWide: dimensions,
//                                          pixelsHigh: dimensions,
//                                          bitsPerSample: 8,
//                                          samplesPerPixel: 4,
//                                          hasAlpha: true,
//                                          isPlanar: true,
//                                          colorSpaceName: .deviceRGB,
//                                          bytesPerRow: 8,
//                                          bitsPerPixel: 8)
    let bitmapImageRep = NSBitmapImageRep(bitmapDataPlanes: nil,
                                          pixelsWide: dimensions,
                                          pixelsHigh: dimensions,
                                          bitsPerSample: 8,
                                          samplesPerPixel: 4,
                                          hasAlpha: true,
                                          isPlanar: true,
                                          colorSpaceName: .deviceRGB,
                                          bitmapFormat: .alphaFirst,
                                          bytesPerRow: 8,
                                          bitsPerPixel: 8)
    
    let image = NSImage(size: kGameTileSize)
    if let bitmap = bitmapImageRep {
      for i in 0..<dimensions {
        for j in 0..<dimensions {
          bitmap.setColor(colors[i * dimensions + j].withAlphaComponent(1.0), atX: i, y: j)
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
