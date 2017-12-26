import Cocoa

class OCRClassifierViewController: NSViewController {

  /// Label that shows how many unclassified images are left.
  let imagesRemainingLabel = NSTextField.label()
  
  /// Button to classify an image.
  lazy var classifyImageButton = {
    return NSButton(title: "Classify Text", target: self, action: #selector(classifyImage))
  }()
  
  /// Image view for showing an image.
  let imageView = NSImageView()
  
  /// Label for showing the image metadata.
  let descriptionLabel = NSTextField.label()
  
  let inputTextField = NSTextField()
  
  var unknownTextURLs = [URL]()
  
  let dataset =
      DatasetManager(classifiedDirectory: kOCRDirectory, unknownDirectory: kOCRUnknownDirectory)
  
  override func viewDidLoad() {
    super.viewDidLoad()
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
    
    inputTextField.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(inputTextField)
    inputTextField.activateFullWidthConstraints(padding: padding)
    inputTextField.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor,
                                        constant: padding).isActive = true
    inputTextField.placeholderString = "Tile Text"
    inputTextField.target = self
    inputTextField.action = #selector(classifyImage)
  }
  
  override func viewDidAppear() {
    super.viewDidAppear()
    // Set image interpolation to none.
    NSGraphicsContext.current?.imageInterpolation = .none
    do {
      unknownTextURLs = try dataset.loadUnknownTiles(ordered: true)
      showNextImage()
    } catch {
      print("cannot load unknown tiles")
    }
  }
  
  @objc func classifyImage() {
    guard let url = unknownTextURLs.first, inputTextField.stringValue.count > 0 else {
      return
    }
    
    let index = kOCRValidCharacters.index(of: inputTextField.stringValue)
    guard index != NSNotFound else {
      return
    }
    
    dataset.classifyTile(imageURL: url, type: index)
    unknownTextURLs.removeFirst()
    showNextImage()
  }
  
  /// Shows the next image and resets the controller's state.
  private func showNextImage() {
    defer {
      imagesRemainingLabel.stringValue = "\(unknownTextURLs.count) images remaining."
      inputTextField.stringValue = ""
    }
    
    guard let imageURL = unknownTextURLs.first else {
      return
    }
    imageView.image = NSImage(byReferencing: imageURL).resize(newSize: imageView.frame.size)
    descriptionLabel.stringValue = imageURL.lastPathComponent
  }
}
