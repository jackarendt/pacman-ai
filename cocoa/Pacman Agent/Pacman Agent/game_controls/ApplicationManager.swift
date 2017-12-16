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
  
  private lazy var tileMatcher = TileMatcher()
  
  private var timer: Timer?
  
  /// The window capture handles capturing screenshots of the target window.
  private lazy var windowCapture: WindowCapture = {
    let capture = WindowCapture(targetWindow: kTargetWindowTitle,
                                targetApplication: kEmulatorApplication)
    capture.delegate = self
    return capture
  }()
  
  private lazy var regularWindowSlider: WindowSlider = {
    return WindowSlider(tileSize: kGameTileSize)
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
  
  func initializeTensorflowModels() {
    tileMatcher.loadVisionModel()
  }
}

extension ApplicationManager: WindowCaptureDelegate {
  func didCaptureWindow(window: NSImage) {
    NotificationCenter.default.post(name: kDidUpdateWindowCaptureNotification, object: window)
    let tiles = regularWindowSlider.tiles(image: window)
    // TODO: Classify image tiles.
    saveUnknownTiles(tiles: tiles)
    saveRandomTiles(tiles: tiles)
  }
  
  func didAcquireWindowMetadata(metadata: [String : Any]) {
    windowCapture.startWindowCapture()
  }
  
  func didFailToAcquireWindowMetadata() {
    print("Window not acquired")
  }
  
  /// Saves unknown tile images to a temp directory.
  private func saveUnknownTiles(tiles: [GameTile]) {
    guard Settings.saveUnknownImages else {
      return
    }
    
    let unknownTiles = tiles.filter({ $0.piece == .unknown })
    if unknownTiles.count == 0 {
      return
    }
    
    if createUnknownTilesDirectoryIfNecessary() {
       for tile in unknownTiles {
        saveTile(tile: tile)
      }
    }
  }
  
  /// Shuffles the first n% tiles, and saves those to disk.
  private func saveRandomTiles(tiles: [GameTile]) {
    var shuffledTiles = tiles
    
    // Get the number of tiles that will be saved.
    let shuffledTileCount = Int(floor(Float(tiles.count) * Settings.imageRandomSamplingFrequency))
    
    // Randomly swap indices until the first n% of tiles are shuffled.
    for i in 0..<shuffledTileCount {
      let j = Int(arc4random_uniform(UInt32(tiles.count - i))) + i
      shuffledTiles.swapAt(i, j)
    }
    
    // Save the shuffled tiles to disk.
    if createUnknownTilesDirectoryIfNecessary() {
      for i in 0..<shuffledTileCount {
        saveTile(tile: shuffledTiles[i])
      }
    }
  }
  
  /// Saves a tile to disk.
  private func saveTile(tile: GameTile) {
    let filename = "\(Int(tile.position.x))_\(Int(tile.position.y))"
    let fullPath = kTileUnknownDirectory + filename + ".tiff"
    let _ = tile.bitmap()?.saveToPath(path: fullPath)
  }
  
  /// Creates an temp directory with all of the unknown tiles if necessary.
  private func createUnknownTilesDirectoryIfNecessary() -> Bool {
    // Create the tmp directory if one doesn't exist.
    if !FileManager.default.fileExists(atPath: kTileUnknownDirectory) {
      do {
        try FileManager.default.createDirectory(atPath: kTileUnknownDirectory,
                                                withIntermediateDirectories: true,
                                                attributes: nil)
      } catch {
        return false
      }
    }
    return true
  }
}
