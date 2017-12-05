import Foundation

class WindowSlider {
  
  let tileSize: CGSize
  
  init(tileSize: CGSize) {
    self.tileSize = tileSize
  }
  
  func tiles(image: NSImage) -> [[GameTile]] {
    guard let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil) else {
      return [[GameTile]]()
    }
    
    let bitmap = NSBitmapImageRep(cgImage: cgImage)
    
    let horizontalTileCount: Int = bitmap.pixelsWide / Int(tileSize.width)
    let verticalTileCount: Int = bitmap.pixelsHigh / Int(tileSize.height)
    
    var tiles = [[GameTile]]()
    tiles.reserveCapacity(horizontalTileCount)
    
    for i in 0..<horizontalTileCount {
      var verticalTiles = [GameTile]()
      verticalTiles.reserveCapacity(verticalTileCount)
      for j in 0..<verticalTileCount {
        verticalTiles.append(tile(x: i, y: j, bitmap: bitmap))
      }
      tiles.append(verticalTiles)
    }
    
    return tiles
  }
  
  private func tile(x: Int, y: Int, bitmap: NSBitmapImageRep) -> GameTile {
    var colors = [NSColor]()
    colors.reserveCapacity(Int(tileSize.width * tileSize.height))
    
    let xOrigin = x * Int(tileSize.width)
    let xFinal = (x + 1) * Int(tileSize.width)
    
    let yOrigin = y * Int(tileSize.width)
    let yFinal = (y + 1) * Int(tileSize.height)
    
    for i in xOrigin..<xFinal {
      for j in yOrigin..<yFinal {
        if let color = bitmap.colorAt(x: i, y: j) {
          colors.append(color)
          if color.redComponent != 0 {

          }
        }
      }
    }
    
    var tile = GameTile(position: CGPoint(x: x, y: y), colors: colors)
    tile.centerPixelCoordinate = CGPoint(x: CGFloat(xFinal - xOrigin) / 2 + CGFloat(xOrigin),
                                         y: CGFloat(yFinal - yOrigin) / 2 + CGFloat(yOrigin))
    return tile
  }
}
