import Foundation

typealias BitmapPointer = UnsafeMutablePointer<PixelComponent>

/// Slides over an image for a given tile size. Each tile has an array of pixel data that will be
/// sent to the vision model.
final class WindowSlider {
  
  /// The size of a tile to slide over an image.
  let tileSize: CGSize
  
  init(tileSize: CGSize) {
    self.tileSize = tileSize
  }
  
  /// Creates an array of game tiles from an image.
  func tiles(image: NSImage) -> [GameTile] {
    guard let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil) else {
      return [GameTile]()
    }
    
    let bitmap = NSBitmapImageRep(cgImage: cgImage)
    var tiles = [GameTile]()
    tiles.reserveCapacity(kGameTileWidth * kGameTileHeight)
    
    weak var weakSelf = self
    let callback: (BitmapPointer?, Int, Int, Int) -> Void = { (buffer, x, y, size) -> Void in
      guard let buffer = buffer, let strongSelf = weakSelf else {
        return
      }
      
      let tile =
          GameTile(position: CGPoint(x: x, y: y), pixels: buffer, bufferLength: size)
      tile.centerPixelCoordinate = CGPoint(x: CGFloat(2 * x + 1) * strongSelf.tileSize.width / 2.0,
                                           y: CGFloat(2 * y + 1) * strongSelf.tileSize.height / 2.0)
      tiles.append(tile)
    }
    
    // Create tiles from the bitmap.
    TileBitmap(bitmap, kGameTileSize, callback)

    return tiles
  }
}

