import Foundation

/// Classifies each tile in the game.
final class TileClassifierNode: PipelineNode {
  var dependencyIdentifiers: [String]? = [WindowSliderNode.identifier]
  
  var enabled: Bool = true
  
  var isOutput: Bool = false
  
  static var identifier: String = "tile_classifier_node"
  
  var executionLevel: Int = -1
  
  private let matcher = TileMatcher()
  
  init() {
    let _ = matcher.loadVisionModel()
  }
  
  func execute(_ input: [String : Any]) throws -> Any {
    guard let tiles = input[WindowSliderNode.identifier] as? [GameTile] else {
      throw PipelineExecutionError.invalidInput
    }
    
    let bufferSize = Int(kGameWidth * kGameHeight) * kSamplesPerPixel
    let pixelBuffer = UnsafeMutablePointer<PixelComponent>.allocate(capacity: bufferSize)
    
    // Copy the pixel values to a 1D buffer containing all pixel values.
    for (i, tile) in tiles.enumerated() {
      for j in 0..<tile.bufferLength {
        pixelBuffer[i * tile.bufferLength + j] = tile.pixels[j]
      }
    }
    
    // Classification buffer is the number of tiles.
    let classificationBufferSize = kGameTileWidth * kGameTileHeight
    let classificationBuffer =
      UnsafeMutablePointer<TileType>.allocate(capacity: classificationBufferSize)
    
    // Predict what tiles are being shown currently.
    matcher.predictions(forTiles: pixelBuffer,
                        tileBuffer: classificationBuffer,
                        confidenceThreshold: Settings.imageClassificationConfidenceThreshold)
    
    // Update what tiles are being shown.
    // Map ignore tiles to blank. This makes the vision sparser, and simpler for the AI to
    // understand.
    for i in 0..<classificationBufferSize {
      var piece = classificationBuffer[i]
      if piece == .ignore {
        piece = .blank
      }
      tiles[i].piece = piece
    }
    
    // Deallocate buffers.
    pixelBuffer.deallocate(capacity: bufferSize)
    classificationBuffer.deallocate(capacity: classificationBufferSize)
    
    return tiles
  }
}
