import Cocoa
import Accelerate

protocol WindowCaptureDelegate: class {
  // Invoked when the target window cannot be found.
  func didFailToAcquireWindowMetadata()
  
  /// Invoked when the target window's metadata was acquired.
  func didAcquireWindowMetadata(metadata: [String: Any])
}

/// Window capture is a class that captures a target window
final class WindowCapture {
  
  weak var delegate: WindowCaptureDelegate?

  let targetWindow: String
  let targetApplication: String
  
  // Wait 10 seconds before timing out.
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
