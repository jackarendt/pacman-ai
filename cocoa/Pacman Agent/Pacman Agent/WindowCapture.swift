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
  let acquisitionStartTime = Date()
  
  var targetWindowMetadata: [String: Any]?
  
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
        self.delegate?.didCaptureWindow(window: image)
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
  
}
