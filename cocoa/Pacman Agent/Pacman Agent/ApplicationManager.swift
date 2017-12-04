import Cocoa

/// Class to represent the pacman game, and perform a bunch of game operations such as opening and
/// closing the game.
class ApplicationManager {
  
  /// Shared instance.
  static let current = ApplicationManager()
  
  /// The absolute path where the game is located.
  private var gamePath: String {
    if let documentsPath =
      NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
      return documentsPath + "/pacman/game/pacman.zip"
    }
    return ""
  }
  
  private var timer: Timer?
  
  /// The window capture handles capturing screenshots of the target window.
  private lazy var windowCapture : WindowCapture = {
    let capture = WindowCapture(targetWindow: kTargetWindowTitle,
                                targetApplication: kEmulatorApplication)
    capture.delegate = self
    return capture
  }()
  
  /// Opens the emulator with pacman open.
  func open() -> Bool {
    guard NSWorkspace.shared.openFile(gamePath, withApplication: kEmulatorApplication) else {
      return false
    }
    
    timer = Timer.scheduledTimer(withTimeInterval: 0.25, repeats: true, block: { timer in
      if let application = NSWorkspace.shared.frontmostApplication {
        if let name = application.localizedName, name == kEmulatorApplication {
          timer.invalidate()
          self.timer = nil
          self.windowCapture.startMetadataAcquisition()
        }
      }
    })
    
    return true
  }
}

extension ApplicationManager: WindowCaptureDelegate {
  func didCaptureWindow(window: NSImage) {
    NotificationCenter.default.post(name: kDidUpdateWindowCaptureNotification, object: window)
  }
  
  func didAcquireWindowMetadata(metadata: [String : Any]) {
    windowCapture.startWindowCapture()
  }
  
  func didFailToAcquireWindowMetadata() {
    print("Window not acquired")
  }
}
