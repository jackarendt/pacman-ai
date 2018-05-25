import Foundation

/// Classifies each tile in the game.
final class OCRNode: PipelineNode {
  var dependencyIdentifiers: [String]? = [TileClassifierNode.identifier]
  
  var enabled: Bool = true
  
  var isOutput: Bool = false
  
  static var identifier: String = "ocr_classifier_node"
  
  var executionLevel: Int = -1
  
  private let model = OCRModel()
  
  init() {
    let _ = model.load()
  }
  
  func execute(_ input: [String : Any]) throws -> Any {
    guard let tiles = input[WindowSliderNode.identifier] as? [GameTile] else {
      throw PipelineExecutionError.invalidInput
    }
    
    let textTiles = tiles.filter({ $0.piece == .text })
    
    let bufferSize =
        textTiles.count * Int(kGameTileSize.width * kGameTileSize.height) * kSamplesPerPixel
    let pixelBuffer = UnsafeMutablePointer<PixelComponent>.allocate(capacity: bufferSize)
    
    // Copy the pixel values to a 1D buffer containing all pixel values.
    for (i, tile) in textTiles.enumerated() {
      for j in 0..<tile.bufferLength {
        pixelBuffer[i * tile.bufferLength + j] = tile.pixels[j]
      }
    }
    
    // Classification buffer is the number of tiles.
    let textBuffer = NSMutableArray()
    
    // Predict what tiles are being shown currently.
    model.predictions(forText: pixelBuffer,
                      textBuffer: textBuffer,
                      numberOfExamples: textTiles.count,
                      confidenceThreshold: Settings.imageClassificationConfidenceThreshold)
    
    // Update what character each tile is are being shown.
    for i in 0..<textBuffer.count {
      textTiles[i].character = textBuffer[i] as! String
    }
    
    // Deallocate buffers.
    pixelBuffer.deallocate()
    
    return tiles
  }
}

