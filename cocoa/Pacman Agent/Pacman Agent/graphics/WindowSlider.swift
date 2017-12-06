import Foundation

typealias BitmapPointer = UnsafeMutablePointer<UInt8>

/// Slides over an image for a given tile size. Each tile has an array of pixel data that will be
/// sent to the vision model.
final class WindowSlider {
  
  /// The size of a tile to slide over an image.
  let tileSize: CGSize
  
  init(tileSize: CGSize) {
    self.tileSize = tileSize
  }
  
  /// Creates a 2-D set of game tiles for each 
  func tiles(image: NSImage) -> [[GameTile]] {
    guard let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil) else {
      return [[GameTile]]()
    }
    
    let bitmap = NSBitmapImageRep(cgImage: cgImage)
    var tiles = [[GameTile]]()
    
    weak var weakSelf = self
    let callback: (BitmapPointer?, Int32, Int32, Int32) -> Void = { (buffer, x, y, size) -> Void in
      guard let buffer = buffer, let strongSelf = weakSelf else {
        return
      }
      
      let tile =
          GameTile(position: CGPoint(x: Int(x), y: Int(y)), pixels: buffer, bufferLength: Int(size))
      tile.centerPixelCoordinate = CGPoint(x: CGFloat(2 * x + 1) * strongSelf.tileSize.width / 2.0,
                                           y: CGFloat(2 * y + 1) * strongSelf.tileSize.height / 2.0)
      
      // Create a new row if the x coordinate resets back to 0.
      if x == 0 {
        tiles.append([GameTile]())
      }
      
      tiles[Int(y)].append(tile)
    }
    
    // Create tiles from the bitmap.
    TileBitmap(bitmap, kGameTileSize, callback)

    return tiles
  }
}

