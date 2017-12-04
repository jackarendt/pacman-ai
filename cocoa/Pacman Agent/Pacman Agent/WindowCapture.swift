import Cocoa

protocol WindowCaptureDelegate: class {
  func didCaptureWindow(window: NSImage)
  func didFailToAcquireWindowMetadata()
  func didAcquireWindowMetadata(metadata: [String: Any])
}

/// Window capture is a class that captures a target window
class WindowCapture {
  
  weak var delegate: WindowCaptureDelegate?

  let targetWindow: String
  let targetApplication: String
  let refreshInterval: TimeInterval = 1.0 / 22.0
  var captureTimer: Timer?
  
  // Wait 5 seconds before timing out.
  let acquisitionTimeout: TimeInterval = 10.0
  var acquisitionTimer: Timer?
  lazy var acquisitionStartTime = Date()
  
  var targetWindowMetadata: [String: Any]?
  
  init(targetWindow: String, targetApplication: String) {
    self.targetWindow = targetWindow
    self.targetApplication = targetApplication
  }
  
  deinit {
    acquisitionTimer?.invalidate()
    captureTimer?.invalidate()
  }
  
  /// Starts acquiring the metadata for all of the windows on screen and checks if any windows match
  /// the desired window name and application. This times out if the target window isn't found in 10
  /// seconds.
  func startMetadataAcquisition() {
    if acquisitionTimer != nil {
      acquisitionTimer?.invalidate()
    }
    
    acquisitionTimer = Timer.scheduledTimer(timeInterval: 0.25,
                                            target: self,
                                            selector: #selector(acquireTargetWindowMetadata),
                                            userInfo: nil,
                                            repeats: true)
  }
  
  /// Starts capturing the target window on a regular interval.
  func startWindowCapture() {
    guard let metadata = targetWindowMetadata,
      let windowID = metadata[kWindowIDKey] as? CGWindowID else {
      return
    }
    
    if captureTimer != nil {
      captureTimer?.invalidate()
    }
    
    let timerBlock: ((Timer) -> ()) = { timer -> Void in
      if let image = CaptureWindowForWindowID(windowID) {
        // Crop and resize the image so that it is ready for post-processing.
        let cropped = self.cropGameWindow(image: image)
        let resized = self.resize(image: cropped)
        self.delegate?.didCaptureWindow(window: resized)
      }
    }
    
    captureTimer =
        Timer.scheduledTimer(withTimeInterval: refreshInterval, repeats: true, block: timerBlock)
  }
  
  /// Stops capturing the target window.
  func endWindowCapture() {
    captureTimer?.invalidate()
    captureTimer = nil
  }
  
  /// Cycles through all of the windows that are currently on screen, and checks for a window that
  /// matches the correct host application and title.
  @objc func acquireTargetWindowMetadata() {
    let target = CaptureWindowMetadata()?.filter({ metadata -> Bool in
      if let appName = metadata[kAppNameKey] as? String,
        let windowName = metadata[kWindowNameKey] as? String {
        return appName == self.targetApplication && windowName == self.targetWindow
      }
      return false
    }).first
    
    targetWindowMetadata = target
    
    if let target = target {
      acquisitionTimer?.invalidate()
      acquisitionTimer = nil
      delegate?.didAcquireWindowMetadata(metadata: target)
    } else if -1 * acquisitionStartTime.timeIntervalSinceNow > acquisitionTimeout {
      delegate?.didFailToAcquireWindowMetadata()
      acquisitionTimer?.invalidate()
      acquisitionTimer = nil
    }
  }
}

// Image post-processing.
extension WindowCapture {
  /// Crops window screenshot to the correct aspect ratio.
  func cropGameWindow(image: NSImage) -> NSImage {
    let width = image.size.height * kGameWidth / kGameHeight
    let height = image.size.height
    let targetXOrigin = (image.size.width - width) / 2
    
    let imageRect = CGRect(x: targetXOrigin, y: 0, width: width, height: height)
    return image.crop(newRect: imageRect)
  }
  
  /// Resizes the game window so that it matches the original dimensions of the game.
  /// - Note: The average window size is just over 1000 pixels tall, but the original pac-man game
  /// is only 288 pixels tall. By resizing the image, the number of input pixels to the tile matcher
  /// decreases from ~916 to 64 without decreasing accuracy.
  func resize(image: NSImage) -> NSImage {
    let newSize = CGSize(width: kGameWidth, height: kGameHeight)
    var newRect = CGRect(origin: CGPoint.zero, size: newSize)
    
    guard let imageRef = image.cgImage(forProposedRect: &newRect, context: nil, hints: nil) else {
      return image
    }
    
    return NSImage(cgImage: imageRef, size: newSize)
  }
}
