import Foundation

/// Pipeline node that saves unknown tiles to disk.
final class UnknownTileSaverNode: PipelineNode {
  var dependencyIdentifiers: [String]? = [TileClassifierNode.identifier]
  
  // This is checked when the pipeline begins. Modifying it after a session starts will have no
  // effect.
  var enabled: Bool = {
    return Settings.saveUnknownImages
  }()
  
  var isOutput: Bool = true
  
  static var identifier: String = "save_unknown_tiles_node"
  
  var localIdentifier: String = UnknownTileSaverNode.identifier
  
  var executionLevel: Int = -1
  
  let datasetManager = DatasetManager(classifiedDirectory: kTileDirectory,
                                      unknownDirectory: kTileUnknownDirectory)

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
    for tile in unknownTiles {
      datasetManager.saveUnknownTile(tile: tile)
    }
    
    return (output: 0, status: .success)
  }
}
