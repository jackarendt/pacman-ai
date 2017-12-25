import Foundation

/// Pipeline node that saves unknown tiles to disk.
final class UnknownTileSaverNode: PipelineNode {
  var dependencyIdentifiers: [String]? = [TileClassifierNode.identifier]
  
  var enabled: Bool {
    get {
      return Settings.saveUnknownImages
    }
  }
  
  var isOutput: Bool = true
  
  static var identifier: String = "save_unknown_tiles_node"
  
  var executionLevel: Int = -1
  
  let datasetManager = DatasetManager(classifiedDirectory: kTileDirectory,
                                      unknownDirectory: kTileUnknownDirectory)

  func execute(_ input: [String : Any]) throws -> Any {
    guard let tiles = input[TileClassifierNode.identifier] as? [GameTile] else {
      throw PipelineExecutionError.invalidInput
    }
    
    // Filter unknown tiles.
    let unknownTiles = tiles.filter({ $0.piece == .unknown })
    if unknownTiles.count == 0 {
      return 0
    }
    
    // Save each unknown tile to the unknown tiles directory.
    for tile in unknownTiles {
      datasetManager.saveUnknownTile(tile: tile)
    }
    
    return 0
  }
}
