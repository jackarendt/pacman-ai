import Cocoa

protocol ApplicationManagerDelegate: class {
  func didUpdateWindowCapture(window: NSImage)
}

/// Class to represent the pacman game, and perform a bunch of game operations such as opening and
/// closing the game.
class ApplicationManager {
  
  static let current = ApplicationManager()
  
  // TODO: Change from delegate to notifications.
  weak var delegate: ApplicationManagerDelegate?
  
  private var gamePath: String {
    if let documentsPath =
      NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
      return documentsPath + "/pacman/game/pacman.zip"
    }
    return ""
  }
  
  private let emulator = "OpenEmu"
  private let game = "pacman"
  
  private var timer: Timer?
  
  private lazy var windowCapture : WindowCapture = {
    let capture = WindowCapture(targetWindow: self.game, targetApplication: self.emulator)
    capture.delegate = self
    return capture
  }()
  
  func open() -> Bool {
    guard NSWorkspace.shared.openFile(gamePath, withApplication: emulator) else {
      return false
    }
    
    timer = Timer.scheduledTimer(withTimeInterval: 0.25, repeats: true, block: { timer in
      if let application = NSWorkspace.shared.frontmostApplication {
        if let name = application.localizedName, name == self.emulator {
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
    delegate?.didUpdateWindowCapture(window: window)
    /**if let desktopPath =
          NSSearchPathForDirectoriesInDomains(.desktopDirectory, .userDomainMask, true).first {
      window.saveToPath(path: desktopPath + "/" + Date().description + ".png")
    } */
  }
  
  func didAcquireWindowMetadata(metadata: [String : Any]) {
    windowCapture.startWindowCapture()
  }
  
  func didFailToAcquireWindowMetadata() {
    print("Window not acquired")
  }
}
