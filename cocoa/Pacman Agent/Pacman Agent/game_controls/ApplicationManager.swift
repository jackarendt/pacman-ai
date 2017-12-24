import Cocoa

/// Class to represent the pacman game, and perform a bunch of game operations such as opening and
/// closing the game.
final class ApplicationManager {
  
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
  
  private var visionPipeline: VisionPipeline?
  
  /// The window capture handles capturing screenshots of the target window.
  private lazy var windowCapture: WindowCapture = {
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
  func didAcquireWindowMetadata(metadata: [String : Any]) {
    visionPipeline = VisionPipeline(windowMetadata: metadata)
    visionPipeline?.start()
  }
  
  func didFailToAcquireWindowMetadata() {
    print("Window not acquired")
  }
  
  /// Shuffles the first n% tiles, and saves those to disk.
  private func saveRandomTiles(tiles: [GameTile]) {
    guard Settings.imageRandomSamplingFrequency > 0 else{
      return
    }
    var shuffledTiles = tiles
    
    // Get the number of tiles that will be saved.
    var shuffledTileCount = Int(floor(Float(tiles.count) * Settings.imageRandomSamplingFrequency))
    
    // Adjust the number of tiles to keep if the keep ratio is less than 1/count.
    // Ex) 100 tiles, .005 keep percentage -> 0.5 chance of keeping 1 tile.
    if shuffledTileCount == 0 {
      let updatedFrequency = Settings.imageRandomSamplingFrequency * Float(tiles.count)
      if UInt32(updatedFrequency * 1000) < arc4random_uniform(1000) {
        shuffledTileCount = 1
      }
    }
    
    // Randomly swap indices until the first n% of tiles are shuffled.
    for i in 0..<shuffledTileCount {
      let j = Int(arc4random_uniform(UInt32(tiles.count - i))) + i
      shuffledTiles.swapAt(i, j)
    }
    
    // Save the shuffled tiles to disk.
//    if createUnknownTilesDirectoryIfNecessary() {
//      for i in 0..<shuffledTileCount {
//        tiles[i].saveBitmap(directory: kTileUnknownDirectory, hashedFilename: true)
//      }
//    }
  }
}
