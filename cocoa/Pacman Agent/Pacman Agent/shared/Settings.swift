import Foundation

/// Helper class for quickly accessing agent/model settings.
class Settings {
  /// Whether images that can't be confidently classified should be saved to train the tile
  /// classification model.
  class var saveUnknownImages: Bool {
    return UserDefaults.standard.bool(forKey: kSaveUnknownImagesKey)
  }
}
