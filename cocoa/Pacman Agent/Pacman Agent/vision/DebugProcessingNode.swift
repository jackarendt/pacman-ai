import Foundation

/// Pipeline node that outputs a formatted text description of the game tiles.
final class DebugProcessingNode: PipelineNode {
  var dependencyIdentifiers: [String]? = [TileClassifierNode.identifier, OCRNode.identifier]
  
  var enabled: Bool = true
  
  var isOutput: Bool = true
  
  static var identifier: String = "debug_processing_node"
  
  var executionLevel: Int = -1

  func execute(_ input: [String : Any]) throws -> Any {
    guard let tiles = input[TileClassifierNode.identifier] as? [GameTile] else {
      throw PipelineExecutionError.invalidInput
    }
    
    let description = tiles.reduce("", { (text, tile) -> String in
      if tile.piece == .text {
        return text + tile.character
      }
      return text + TileModel.character(for: tile.piece)
    })
    
    // Format the string so that it is ordered in as a game board.
    var formattedString = ""
    for row in 0..<kGameTileHeight {
      let startIndex = description.index(description.startIndex, offsetBy: row * kGameTileWidth)
      let endIndex = description.index(description.startIndex, offsetBy: (row + 1) * kGameTileWidth)
      formattedString += description[startIndex..<endIndex] + "\n"
    }
    
    NotificationCenter.default.post(name: kDidUpdateWindowCaptureNotification,
                                    object: formattedString)
    
    return 0
  }
}
