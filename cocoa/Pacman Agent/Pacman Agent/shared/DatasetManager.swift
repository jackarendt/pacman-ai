import Foundation

/// Manages a dataset by saving and retrieving classified and unknown tiles.
final class DatasetManager {
  /// The directory of the classified tiles.
  let classifiedDirectory: String
  
  // The directory of the unknown tiles.
  let unknownDirectory: String
  
  /// The path of the classified labels csv.
  var csvPath: String {
    get {
      return self.classifiedDirectory + kImageMappingCSVFilename
    }
  }
  
  init(classifiedDirectory: String, unknownDirectory: String) {
    self.classifiedDirectory = classifiedDirectory
    self.unknownDirectory = unknownDirectory
    
    // Create the directories for the unknown and classified tiles.
    createDirectoryIfNecessary(directory: self.classifiedDirectory)
    createDirectoryIfNecessary(directory: self.unknownDirectory)
    
    // Create the image mapping key for the classified tiles if one does not exist.
    if !FileManager.default.fileExists(atPath: csvPath) {
      let data = "image,label\n".data(using: .utf8)
      FileManager.default.createFile(atPath: csvPath, contents: data, attributes: nil)
    }
  }
  
  /// Saves a tile to the unknown tile directory.
  func saveUnknownTile(tile: GameTile) {
    let filename = "\(Int(tile.position.x))_\(Int(tile.position.y))"
    let fullPath = unknownDirectory + filename + ".tiff"
    let _ = tile.bitmap()?.saveToPath(path: fullPath)
  }
  
  /// Loads unknown tiles and returns the URLs.
  /// - Parameter ordered: Whether the URLs should be returned in ascending order.
  func loadUnknownTiles(ordered: Bool) throws -> [URL] {
    let url = URL(fileURLWithPath: unknownDirectory)
    var images = [URL]()
    do {
      try images = FileManager.default.contentsOfDirectory(at: url,
                                                           includingPropertiesForKeys: nil,
                                                           options: .skipsHiddenFiles)
    } catch {
      throw error
    }
    
    // Return the unordered images if they shouldn't be ordered.
    if (!ordered) {
      return images
    }
    
    // Sort the images by row then column. So 6_27 will come before 7_2. If a filename is hashed,
    // this is not guaranteed to work.
    return images.sorted(by: { (url1, url2) -> Bool in
      let firstPath = url1.lastPathComponent.replacingOccurrences(of: "tiff", with: "")
        .replacingOccurrences(of: ".", with: "_")
      let secondPath = url2.lastPathComponent.replacingOccurrences(of: "tiff", with: "")
        .replacingOccurrences(of: ".", with: "_")
      
      let firstDigits = firstPath.components(separatedBy: "_").map { Int($0) }
      let secondDigits = secondPath.components(separatedBy: "_").map { Int($0) }
      
      for i in 0..<firstDigits.count {
        if let firstDigit = firstDigits[i], let secondDigit = secondDigits[i] {
          if firstDigit != secondDigit {
            return firstDigit < secondDigit
          }
        }
      }
      
      return true
    })
  }
  
  /// Saves a tile to the classified directory with an associated type.
  func classifyTile(imageURL: URL, type: Int) {
    // Create the file URL in the classified directory.
    let saltedName = imageURL.lastPathComponent + Date().description + arc4random().description
    let filename = abs(saltedName.hash).description + "." + imageURL.pathExtension
    let fileURL = URL(fileURLWithPath: classifiedDirectory + filename)
    
    do {
      // Copy the image to the classified directory, update the labels file, and remove the unknown
      // image.
      try FileManager.default.copyItem(at: imageURL, to: fileURL)
      let newLine = filename + "," + type.description + "\n"
      if let file = FileHandle(forUpdatingAtPath: csvPath), let data = newLine.data(using: .utf8) {
        file.seekToEndOfFile()
        file.write(data)
        file.closeFile()
      }
      try FileManager.default.removeItem(at: imageURL)
    } catch {
      print("File not copied")
    }
  }

  /// Creates an temp directory with all of the unknown tiles if necessary.
  private func createDirectoryIfNecessary(directory: String) {
    // Create the tmp directory if one doesn't exist.
    if !FileManager.default.fileExists(atPath: directory) {
      try? FileManager.default.createDirectory(atPath: directory,
                                               withIntermediateDirectories: true,
                                               attributes: nil)
    }
  }
}
