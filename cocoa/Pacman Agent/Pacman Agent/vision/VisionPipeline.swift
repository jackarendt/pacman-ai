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
    let unknownNode = UnknownTileSaverNode()
    let debugNode = DebugProcessingNode()
    initializeWithNodes(nodes: [captureNode, sliderNode, classifierNode, unknownNode, debugNode])
  }
}