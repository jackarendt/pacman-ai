import Foundation

/// Pipeline for visually analyzing the pacman game screen. This starts with capaturing the game
/// screen, and eventually outputs what the model views.
final class VisionPipeline: Pipeline {
  init(windowMetadata: [String: Any]) {
    super.init()
    self.refreshInterval = 1.0 / 11.0
    let captureNode = WindowCaptureNode(options: windowMetadata)
    let sliderNode = WindowSliderNode()
    let classifierNode = TileClassifierNode()
    let ocrNode = OCRNode()
    let unknownNode = UnknownTileSaverNode()
    let debugNode = DebugProcessingNode()
    let ocrSaverNode = OCRTileSaverNode()
    
    let nodes: [PipelineNode] = [
      captureNode,
      sliderNode,
      classifierNode,
      ocrNode,
      unknownNode,
      debugNode,
      ocrSaverNode
    ]
    initializeWithNodes(nodes: nodes)
  }
}
