import Foundation

/// Pipeline node that captures a window, then crops and resizes it so that it can be interpreted
/// by the tile model.
final class WindowCaptureNode: PipelineNode {
  
  var dependencyIdentifiers: [String]? = nil
  
  var enabled: Bool = true
  
  var isOutput: Bool = false
  
  static var identifier: String = "window_capture_node"
  
  var localIdentifier: String = WindowCaptureNode.identifier
  
  var executionLevel: Int = -1
  
  private let windowID: CGWindowID
  
  init(options: [String : Any]) {
    // Get the windowID from the window metadata.
    if let id = options[kWindowIDKey] as? CGWindowID {
      self.windowID = id
    } else {
      self.windowID = UInt32.max
    }
  }
  
  func execute(_ input: [String: Any]) -> (output: Any, status: ExecutionStatus)  {
    if let image = CaptureWindowForWindowID(windowID) {
      let cropped = cropGameWindow(image: image)
      return (output: resize(image: cropped), status: .success)
    }
    return (output: NSImage(), status: .failure)
  }
  
  /// Crops window screenshot to the correct aspect ratio.
  private func cropGameWindow(image: NSImage) -> NSImage {
    let topBorder: CGFloat = 22.0 * NSScreen.main!.backingScaleFactor
    let bottomBorder: CGFloat = 2.0 * NSScreen.main!.backingScaleFactor
    let height = image.size.height - topBorder - bottomBorder
    let width = floor(height * (kGameWidth - kGameTileSize.width) / kGameHeight)
    let targetXOrigin = (image.size.width - width) / 2
    
    let imageRect = CGRect(x: targetXOrigin, y: topBorder, width: width, height: height)
    return image.crop(newRect: imageRect)
  }
  
  /// Resizes the game window so that it matches the original dimensions of the game.
  /// - Note: The average window size is just over 1000 pixels tall, but the original pac-man game
  /// is only 288 pixels tall. By resizing the image, the number of inputs to the tile matcher
  /// decreases from 3500+ to 256 without decreasing accuracy.
  private func resize(image: NSImage) -> NSImage {
    guard let scale = NSScreen.main?.backingScaleFactor else {
      return image
    }
    
    let newSize = CGSize(width: kGameWidth / scale, height: kGameHeight / scale)
    return image.resize(newSize: newSize)
  }
}
