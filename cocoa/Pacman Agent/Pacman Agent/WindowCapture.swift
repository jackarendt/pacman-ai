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
  let acquisitionTimeout: TimeInterval = 5.0
  var acquisitionTimer: Timer?
  lazy var acquisitionStartTime = Date()
  
  var targetWindowMetadata: [String: Any]?
  let gameAspectRatio: CGFloat = 26.0 / 36.0
  let imageScaleFactor: CGFloat = 0.5
  
  init(targetWindow: String, targetApplication: String) {
    self.targetWindow = targetWindow
    self.targetApplication = targetApplication
  }
  
  deinit {
    acquisitionTimer?.invalidate()
    captureTimer?.invalidate()
  }
  
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
  
  /// Captures the desired window
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
        let cropped = self.cropGameWindow(image: image)
        let resized = self.resize(image: cropped, scale: self.imageScaleFactor)
        self.delegate?.didCaptureWindow(window: resized)
      }
    }
    
    captureTimer =
        Timer.scheduledTimer(withTimeInterval: refreshInterval, repeats: true, block: timerBlock)
  }
  
  func endWindowCapture() {
    captureTimer?.invalidate()
    captureTimer = nil
  }
  
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
  func cropGameWindow(image: NSImage) -> NSImage {
    let targetWidth = image.size.height * gameAspectRatio
    let targetHeight = image.size.height
    let targetXOrigin = (image.size.width - targetWidth) / 2
    
    let imageRect = CGRect(x: targetXOrigin, y: 0, width: targetWidth, height: targetHeight)
    return image.crop(newRect: imageRect)
  }
  
  func resize(image: NSImage, scale: CGFloat) -> NSImage {
    let newSize = CGSize(width: image.size.width * scale, height: image.size.height * scale)
    var newRect = CGRect(origin: CGPoint.zero, size: newSize)
    
    guard let imageRef = image.cgImage(forProposedRect: &newRect, context: nil, hints: nil) else {
      return image
    }
    
    return NSImage(cgImage: imageRef, size: newSize)
  }
}
