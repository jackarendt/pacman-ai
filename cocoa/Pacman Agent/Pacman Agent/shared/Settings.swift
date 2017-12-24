import Foundation

/// Helper class for quickly accessing agent/model settings.
class Settings {
  /// Whether images that can't be confidently classified should be saved to train the tile
  /// classification model.
  class var saveUnknownImages: Bool {
    return UserDefaults.standard.bool(forKey: kSaveUnknownImagesKey)
  }
  
  /// What confidence threshold is required to classify a tile as a certain type.
  class var imageClassificationConfidenceThreshold: Float {
    return UserDefaults.standard.float(forKey: kClassificationConfidenceThresholdKey)
  }
  
  /// The percentage of tiles that should be saved for classification, even if they've been
  /// correctly identified.
  class var imageRandomSamplingFrequency: Float {
    return UserDefaults.standard.float(forKey: kRandomImageSamplingFrequencyKey)
  }
  
  /// Whether all images that have been classified as text should be saved to train the OCR model.
  class var saveAllTextImages: Bool {
    return UserDefaults.standard.bool(forKey: kSaveAllTextImagesKey)
  }
}
