import Foundation

/// Pipeline node that outputs a formatted text description of the game tiles.
final class DebugProcessingNode: PipelineNode {
  var dependencyIdentifiers: [String]? = [TileClassifierNode.identifier]
  
  var enabled: Bool = true
  
  var isOutput: Bool = true
  
  static var identifier: String = "debug_processing_node"
  
  var executionLevel: Int = -1

  func execute(_ input: [String : Any]) -> (output: Any, status: ExecutionStatus) {
    guard let tiles = input[TileClassifierNode.identifier] as? [GameTile] else {
      return (output: 0, status: .failure)
    }
    
    let description = tiles.reduce("", { $0 + TileMatcher.character(for: $1.piece) })
    
    // Format the string so that it is ordered in as a game board.
    var formattedString = ""
    for row in 0..<kGameTileHeight {
      let startIndex = description.index(description.startIndex, offsetBy: row * kGameTileWidth)
      let endIndex = description.index(description.startIndex, offsetBy: (row + 1) * kGameTileWidth)
      formattedString += description[startIndex..<endIndex] + "\n"
    }
    
    NotificationCenter.default.post(name: kDidUpdateWindowCaptureNotification,
                                    object: formattedString)
    
    return (output: 0, status: .success)
  }
}
