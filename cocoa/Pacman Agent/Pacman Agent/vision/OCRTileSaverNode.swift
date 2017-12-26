import Foundation

final class OCRTileSaverNode: PipelineNode {
  var dependencyIdentifiers: [String]? = [TileClassifierNode.identifier]
  
  var enabled: Bool {
    get {
      return Settings.saveAllTextImages
    }
  }
  
  var isOutput: Bool = true
  
  static var identifier: String = "ocr_tile_saver_node"
  
  var executionLevel: Int = -1
  
  let datasetManager = DatasetManager(classifiedDirectory: kOCRDirectory,
                                      unknownDirectory: kOCRUnknownDirectory)
  
  func execute(_ input: [String : Any]) throws -> Any {
    guard let tiles = input[TileClassifierNode.identifier] as? [GameTile] else {
      throw PipelineExecutionError.invalidInput
    }
    
    // Filter text tiles.
    let textTiles = tiles.filter({ $0.piece == .text })
    if textTiles.count == 0 {
      return 0
    }
    
    // Save each text tile to the text tiles directory.
    for tile in textTiles {
      datasetManager.saveUnknownTile(tile: tile)
    }
    
    return 0
  }
}
