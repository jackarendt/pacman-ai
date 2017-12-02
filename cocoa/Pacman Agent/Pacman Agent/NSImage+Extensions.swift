import Cocoa

extension NSImage {
  func saveToPath(path: String) -> Bool {
    if let imageRef = cgImage(forProposedRect: nil, context: nil, hints: nil) {
      let bitmap = NSBitmapImageRep(cgImage: imageRef)
      bitmap.size = size
      let data = bitmap.representation(using: .png, properties: [:])
      do {
        try data?.write(to: URL(fileURLWithPath: path))
        return true
      } catch {
        return false
      }
    }
    return false
  }
}
