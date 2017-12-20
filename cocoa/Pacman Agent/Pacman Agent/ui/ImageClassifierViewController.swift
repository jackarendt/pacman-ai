import Cocoa

/// View controller for classifying different unknown images.
class ImageClassifierViewController: NSViewController {
  
  /// Label that shows how many unclassified images are left.
  let imagesRemainingLabel = NSTextField.label()
  
  /// Button to classify an image.
  lazy var classifyImageButton = {
     return NSButton(title: "Classify Image", target: self, action: #selector(classifyImage))
  }()
  
  /// Image view for showing an image.
  let imageView = NSImageView()
  
  /// Label for showing the image metadata.
  let descriptionLabel = NSTextField.label()
  
  /// Array of radio buttons.
  var buttons = [NSButton]()
  
  /// URLs for where the unknown images are located.
  var unknownImageURLs = [URL]()
  
  /// The different types of tiles.
  var tileTypes = [TileType]()
  
  /// The currently selected type.
  var selectedType: TileType = .unknown
  
  override func viewDidLoad() {
    super.viewDidLoad()
    loadTileTypes()
    
    let padding: CGFloat = 20
    
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.imageScaling = .scaleProportionallyUpOrDown
    view.addSubview(imageView)
    imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor,
                                     multiplier: 1.0).isActive = true
    imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding).isActive = true
    imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    
    descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(descriptionLabel)
    descriptionLabel.alignment = .center
    descriptionLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
    descriptionLabel.activateFullWidthConstraints(padding: padding)
    descriptionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor,
                                          constant: 5).isActive = true
    
    imagesRemainingLabel.translatesAutoresizingMaskIntoConstraints = false
    imagesRemainingLabel.alignment = .center
    view.addSubview(imagesRemainingLabel)
    imagesRemainingLabel.activateFullWidthConstraints(padding: padding)
    imagesRemainingLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
    imagesRemainingLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                                 constant: -5).isActive = true
    
    classifyImageButton.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(classifyImageButton)
    classifyImageButton.activateFullWidthConstraints(padding: padding)
    classifyImageButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
    classifyImageButton.bottomAnchor.constraint(equalTo: imagesRemainingLabel.topAnchor,
                                                constant: -5).isActive = true
    
    let stackView = createRadioStackView()
    view.addSubview(stackView)
    stackView.activateFullWidthConstraints(padding: padding)
    stackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor,
                                   constant: 10).isActive = true
    stackView.bottomAnchor.constraint(equalTo: classifyImageButton.topAnchor,
                                      constant: -10).isActive = true
  }
  
  override func viewDidAppear() {
    super.viewDidAppear()
    // Set image interpolation to none.
    NSGraphicsContext.current?.imageInterpolation = .none
    
    let url = URL(fileURLWithPath: kTileUnknownDirectory)
    if let images = try? FileManager.default.contentsOfDirectory(at: url,
                                                                 includingPropertiesForKeys: nil,
                                                                 options: .skipsHiddenFiles) {
      unknownImageURLs = images.sorted(by: { (url1, url2) -> Bool in
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
      showNextImage()
    }
  }
  
  // MARK: - Private functions

  /// Shows the next image and resets the controller's state.
  private func showNextImage() {
    defer {
      selectedType = .unknown
      classifyImageButton.isEnabled = false
      imagesRemainingLabel.stringValue = "\(unknownImageURLs.count) images remaining."
      
      for button in buttons {
        button.state = .off
      }
    }
    
    guard let imageURL = unknownImageURLs.first else {
      return
    }
    imageView.image = NSImage(byReferencing: imageURL).resize(newSize: imageView.frame.size)
    descriptionLabel.stringValue = imageURL.lastPathComponent
  }
  
  /// Loads the different tile types from a buffer.
  private func loadTileTypes() {
    let typeBuffer = UnsafeMutablePointer<TileType>.allocate(capacity: kTileTypeCount)
    TileMatcher.allTileTypes(typeBuffer)
    
    for i in 0..<kTileTypeCount {
      tileTypes.append(typeBuffer[i])
    }
    typeBuffer.deallocate(capacity: Int(kTileTypeCount))
  }
  
  /// Creates the stackview for showing different tile classes.
  private func createRadioStackView() -> NSStackView {
    let stackView = NSStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.alignment = .top
    stackView.orientation = .horizontal
    stackView.spacing = 0
    stackView.distribution = .fillEqually
    
    let columns = 2
    let rows = kTileTypeCount / columns
    for column in stride(from: 0, to: columns, by: 1) {
      let columnStackView = NSStackView()
      columnStackView.translatesAutoresizingMaskIntoConstraints = false
      columnStackView.alignment = .left
      columnStackView.orientation = .vertical
      columnStackView.spacing = 0
      columnStackView.distribution = .equalSpacing
      
      for type in tileTypes[column * rows..<(column + 1) * rows] {
        let description = TileMatcher.description(for: type)
        let button = NSButton(radioButtonWithTitle: description!,
                              target: self,
                              action: #selector(radioButtonClicked(sender:)))
        button.tag = type.rawValue
        columnStackView.addArrangedSubview(button)
        button.activateFullWidthConstraints(padding: 0)
        button.heightAnchor.constraint(equalToConstant: 20).isActive = true
        buttons.append(button)
      }
      stackView.addArrangedSubview(columnStackView)
    }
    
    return stackView
  }
  
  // MARK: - Selectors
  
  /// Classifies an image and saves it to the dataset directory.
  @objc func classifyImage() {
    guard let url = unknownImageURLs.first else {
      return
    }
    
    saveImageToDataset(imageURL: url)
    unknownImageURLs.removeFirst()
    showNextImage()
  }
  
  @objc func radioButtonClicked(sender: NSButton) {
    guard let type = TileType(rawValue: sender.tag) else {
      return
    }
    
    selectedType = type
    classifyImageButton.isEnabled = true
    
    for (idx, button) in buttons.enumerated() {
      if idx == type.rawValue {
        button.state = .on
      } else {
        button.state = .off
      }
    }
  }
}

// MARK: - Image saving methods
extension ImageClassifierViewController {
  private func saveImageToDataset(imageURL: URL) {
    createDataDirectoryIfNecessary()
    
    let saltedName = imageURL.lastPathComponent + Date().description + arc4random().description
    let filename = abs(saltedName.hash).description + "." + imageURL.pathExtension
    let fileURL = URL(fileURLWithPath: kTileDirectory + filename)
    
    do {
      try FileManager.default.copyItem(at: imageURL, to: fileURL)
      updateCSV(imageName: filename)
      try FileManager.default.removeItem(at: imageURL)
    } catch {
      print("File not copied")
    }
  }
  
  private func updateCSV(imageName: String) {
    let csv = kTileDirectory + kImageMappingCSVFilename
    if !FileManager.default.fileExists(atPath: csv) {
      FileManager.default.createFile(atPath: csv, contents: nil, attributes: nil)
    }
    
    let newLine = imageName + "," + selectedType.rawValue.description + "\n"
    
    if let file = FileHandle(forUpdatingAtPath: csv), let data = newLine.data(using: .utf8) {
      file.seekToEndOfFile()
      file.write(data)
      file.closeFile()
    }
  }
  
  private func createDataDirectoryIfNecessary() {
    if !FileManager.default.fileExists(atPath: kTileDirectory) {
      do {
        try FileManager.default.createDirectory(atPath: kTileDirectory,
                                                withIntermediateDirectories: true,
                                                attributes: nil)
      } catch {
        return
      }
    }
  }
}
