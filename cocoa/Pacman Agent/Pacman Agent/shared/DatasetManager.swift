import Foundation

/// Manages a dataset by saving and retrieving classified and unknown tiles.
final class DatasetManager {
  let classifiedDirectory: String
  let unknownDirectory: String
  
  init(classifiedDirectory: String, unknownDirectory: String) {
    self.classifiedDirectory = classifiedDirectory
    self.unknownDirectory = unknownDirectory
    
    createDirectoryIfNecessary(directory: self.classifiedDirectory)
    createDirectoryIfNecessary(directory: self.unknownDirectory)
  }
  
  func saveUnknownTile(tile: GameTile) {
    let _ = tile.saveBitmap(directory: unknownDirectory)
  }
  
  /// Loads unknown tiles and returns the URLs in ascending order.
  func loadUnknownTiles(ordered: Bool) -> [URL] {
    return [URL]()
  }
  
  func classifyTile(image: String, type: TileType) {
    
  }
  
  /// Creates an temp directory with all of the unknown tiles if necessary.
  private func createDirectoryIfNecessary(directory: String) {
    // Create the tmp directory if one doesn't exist.
    if !FileManager.default.fileExists(atPath: directory) {
      try? FileManager.default.createDirectory(atPath: directory,
                                               withIntermediateDirectories: true,
                                               attributes: nil)
    }
  }
}
