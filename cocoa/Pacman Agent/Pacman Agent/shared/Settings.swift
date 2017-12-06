import Foundation

class Settings {
  class var saveUnknownImages: Bool {
    return UserDefaults.standard.bool(forKey: kSaveUnknownImagesKey)
  }
}
