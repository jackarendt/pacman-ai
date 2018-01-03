import Foundation

// MARK: - Game and Emulator Constants.

/// The name of the emulator that plays pacman.
public let kEmulatorApplication = "OpenEmu"

/// The name of the window where pacman will be played.
public let kTargetWindowTitle = "pacman"

/// Directory for retrieving saved tiles.
public var kTileDirectory: String = {
  guard let documentDirectory =
      NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else {
      return ""
  }
  return documentDirectory + "/pacman/vision/tiles/"
}()

/// Directory for retrieving saved OCR images.
public var kOCRDirectory: String = {
  guard let documentDirectory =
    NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else {
      return ""
  }
  return documentDirectory + "/pacman/vision/ocr/"
}()

public let kImageMappingCSVFilename = "labels.csv"

/// Directory for saving unknown tile images.
public let kTileUnknownDirectory: String = "/tmp/pacman/tiles/unknown/"

/// Directory for saving unknown OCR images.
public let kOCRUnknownDirectory: String = "/tmp/pacman/ocr/unknown/"

// MARK: - Game Graphics Constants.

/// The total width of the game screen.
public var kGameWidth: CGFloat = {
  return CGFloat(kGameTileWidth) * kGameTileSize.width
}()

/// The total height of the game screen.
public var kGameHeight: CGFloat = {
  return CGFloat(kGameTileHeight) * kGameTileSize.height
}()

// MARK: - Notificiations

/// Notification that is posted when the window is captured.
public let kDidUpdateWindowCaptureNotification = Notification.Name("did_update_window_capture")

// MARK: - Settings keys
public let kSaveUnknownImagesKey = "save_unknown_images"

public let kClassificationConfidenceThresholdKey = "classification_confidence_threshold"

public let kRandomImageSamplingFrequencyKey = "random_image_sampling_frequency"

public let kSaveAllTextImagesKey = "save_text_ocr"
