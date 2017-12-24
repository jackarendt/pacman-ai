import Foundation

typealias BitmapPointer = UnsafeMutablePointer<PixelComponent>

/// Pipeline node that slides over an image to separate the image into a 28x36 grid of tiles. It
/// returns a 1D array of tiles that are organized per row.
final class WindowSliderNode: PipelineNode {
  
  /// The window slider depends on the window capture.
  var dependencyIdentifiers: [String]? = [WindowCaptureNode.identifier]
  
  var enabled: Bool = true
  
  var isOutput: Bool = false
  
  static var identifier: String = "window_slider_node"
  
  var executionLevel: Int = -1
  
  func execute(_ input: [String : Any]) -> (output: Any, status: ExecutionStatus) {
    guard let image = input[WindowCaptureNode.identifier] as? NSImage,
          let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil) else {
      return (output: [GameTile](), status: .failure)
    }
    
    let bitmap = NSBitmapImageRep(cgImage: cgImage)
    var tiles = [GameTile]()
    tiles.reserveCapacity(kGameTileWidth * kGameTileHeight)
    
    // Create tiles from the bitmap.
    TileBitmap(bitmap, { (buffer, x, y, size) -> Void in
      guard let buffer = buffer else {
        return
      }
      
      let tile = GameTile(position: CGPoint(x: x, y: y), pixels: buffer, bufferLength: size)
      tile.centerPixelCoordinate = CGPoint(x: CGFloat(2 * x + 1) * kGameTileSize.width / 2.0,
                                           y: CGFloat(2 * y + 1) * kGameTileSize.height / 2.0)
      tiles.append(tile)
    })
    
    return (output: tiles, status: .success)
  }
}
