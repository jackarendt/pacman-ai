import Foundation

/// Pipeline node that saves unknown tiles to disk.
final class UnknownTileSaverNode: PipelineNode {
  var dependencyIdentifiers: [String]? = [TileClassifierNode.identifier]
  
  var enabled: Bool = {
    return Settings.saveUnknownImages
  }()
  
  var isOutput: Bool = true
  
  static var identifier: String = "save_unknown_tiles_node"
  
  var localIdentifier: String = UnknownTileSaverNode.identifier
  
  var executionLevel: Int = -1
  
  func execute(_ input: [String : Any]) -> (output: Any, status: ExecutionStatus) {
    guard let tiles = input[TileClassifierNode.identifier] as? [GameTile] else {
      return (output: 0, status: .failure)
    }
    
    // Filter unknown tiles.
    let unknownTiles = tiles.filter({ $0.piece == .unknown })
    if unknownTiles.count == 0 {
      return (output: 0, status: .success)
    }
    
    // Save each unknown tile to the unknown tiles directory.
    if createUnknownTilesDirectoryIfNecessary() {
      for tile in unknownTiles {
        let _ = tile.saveBitmap(directory: kTileUnknownDirectory)
      }
    }
    
    return (output: 0, status: .success)
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
