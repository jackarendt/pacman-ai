import Cocoa

extension NSBitmapImageRep {
  func saveToPath(path: String) -> Bool {
    do {
      try tiffRepresentation?.write(to: URL(fileURLWithPath: path), options: .atomicWrite)
      return true
    } catch {
      return false
    }
  }
}

extension NSImage {
  /// Saves an image to a specified path.
  func saveToPath(path: String) -> Bool {
    if let imageRef = cgImage(forProposedRect: nil, context: nil, hints: nil) {
      let bitmap = NSBitmapImageRep(cgImage: imageRef)
      bitmap.size = size
      return bitmap.saveToPath(path: path)
    }
    return false
  }
  
  /// Crops an image to a specified rect.
  func crop(newRect: NSRect) -> NSImage {    
    guard let cgImage = self.cgImage(forProposedRect: nil, context: nil, hints: nil) else {
      return self
    }
    
    guard let cropped = cgImage.cropping(to: newRect) else {
      return self
    }
    
    return NSImage(cgImage: cropped, size: newRect.size)
  }
  
  // Resizes an image to the specified dimensions.
  func resize(newSize: CGSize) -> NSImage {
    let resized = CGRect(origin: CGPoint.zero, size: newSize)
    let original = CGRect(origin: CGPoint.zero, size: size)
    
    let smallImage = NSImage(size: newSize)
    smallImage.lockFocus()
    NSGraphicsContext.current?.imageInterpolation = .none
    NSGraphicsContext.current?.shouldAntialias = false
    draw(in: resized, from: original, operation: .copy, fraction: 1.0)
    smallImage.unlockFocus()
    return smallImage
  }
}
