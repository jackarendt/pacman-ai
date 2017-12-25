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
  
  let classifier = ClassificationSelectionView(frame: CGRect.zero)
  
  /// URLs for where the unknown images are located.
  var unknownImageURLs = [URL]()
  
  let dataset =
    DatasetManager(classifiedDirectory: kTileDirectory, unknownDirectory: kTileUnknownDirectory)
  
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
    
    classifier.delegate = self
    classifier.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(classifier)
    classifier.activateFullWidthConstraints(padding: padding)
    classifier.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor,
                                    constant: 10).isActive = true
    classifier.bottomAnchor.constraint(equalTo: classifyImageButton.topAnchor,
                                       constant: -10).isActive = true
  }
  
  override func viewDidAppear() {
    super.viewDidAppear()
    // Set image interpolation to none.
    NSGraphicsContext.current?.imageInterpolation = .none
    do {
      unknownImageURLs = try dataset.loadUnknownTiles(ordered: true)
    } catch {
      print("cannot load unknown tiles")
    }
  }
  
  // MARK: - Private functions

  /// Shows the next image and resets the controller's state.
  private func showNextImage() {
    defer {
      classifyImageButton.isEnabled = false
      imagesRemainingLabel.stringValue = "\(unknownImageURLs.count) images remaining."
      classifier.clearSelection()
    }
    
    guard let imageURL = unknownImageURLs.first else {
      return
    }
    imageView.image = NSImage(byReferencing: imageURL).resize(newSize: imageView.frame.size)
    descriptionLabel.stringValue = imageURL.lastPathComponent
  }
  
  // MARK: - Selectors
  
  /// Classifies an image and saves it to the dataset directory.
  @objc func classifyImage() {
    guard let url = unknownImageURLs.first else {
      return
    }
    
    dataset.classifyTile(imageURL: url, type: classifier.selectedType.rawValue)
    unknownImageURLs.removeFirst()
    showNextImage()
  }
}

extension ImageClassifierViewController: ClassificationSelectionViewDelegate {
  func selectionViewDidChange(selectionView: ClassificationSelectionView) {
    classifyImageButton.isEnabled = true
  }
}
