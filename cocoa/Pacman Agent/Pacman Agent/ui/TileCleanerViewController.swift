import Cocoa

/// View controller for cleaning misclassified data.
class TileCleanerViewController: NSViewController {
  
  let popupClassifier = NSPopUpButton(frame: NSRect.zero, pullsDown: true)
  
  /// Button to classify an image.
  lazy var classifyImageButton = {
    return NSButton(title: "Fix Classification", target: self, action: #selector(classifyImage))
  }()
  
  lazy var nextButton = {
    return NSButton(title: "Next >", target: self, action: #selector(nextImage))
  }()
  
  lazy var previousButton = {
    return NSButton(title: "< Previous", target: self, action: #selector(previousImage))
  }()
  
  /// Image view for showing an image.
  let imageView = NSImageView()
  
  let classifier = ClassificationSelectionView(frame: NSRect.zero)
  
  /// Label that shows how many unclassified images are left.
  let imagesRemainingLabel = NSTextField.label()
  
  let dataset =
        DatasetManager(classifiedDirectory: kTileDirectory, unknownDirectory: kTileUnknownDirectory)
  var allLabels = [String: TileType]()
  var tileLabels = [String: TileType]()
  
  // Current index of the
  var currentIndex = 0

  override func viewDidLoad() {
    super.viewDidLoad()
    let padding: CGFloat = 20
    
    popupClassifier.target = self
    popupClassifier.action = #selector(classifierChanged)

    let tileDescriptions = classifier.tileTypes.map({ TileModel.description(for: $0)! })
    popupClassifier.addItems(withTitles: tileDescriptions)
    popupClassifier.autoenablesItems = true
    popupClassifier.selectItem(at: 0)
    popupClassifier.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(popupClassifier)
    popupClassifier.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
    popupClassifier.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.imageScaling = .scaleProportionallyUpOrDown
    view.addSubview(imageView)
    imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor,
                                     multiplier: 1.0).isActive = true
    imageView.topAnchor.constraint(equalTo: popupClassifier.bottomAnchor,
                                   constant: padding).isActive = true
    imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    
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
    
    classifier.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(classifier)
    classifier.activateFullWidthConstraints(padding: padding)
    classifier.topAnchor.constraint(equalTo: imageView.bottomAnchor,
                                    constant: 10).isActive = true
    classifier.bottomAnchor.constraint(equalTo: classifyImageButton.topAnchor,
                                       constant: -10).isActive = true
    
    nextButton.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(nextButton)
    nextButton.topAnchor.constraint(equalTo: popupClassifier.bottomAnchor,
                                    constant: padding).isActive = true
    nextButton.leadingAnchor.constraint(equalTo: imageView.trailingAnchor,
                                        constant: padding).isActive = true
    
    previousButton.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(previousButton)
    previousButton.topAnchor.constraint(equalTo: popupClassifier.bottomAnchor,
                                        constant: padding).isActive = true
    previousButton.trailingAnchor.constraint(equalTo: imageView.leadingAnchor,
                                             constant: -padding).isActive = true
  }
  
  override func viewDidAppear() {
    super.viewDidAppear()
    // Set image interpolation to none.
    NSGraphicsContext.current?.imageInterpolation = .none
    
    loadLabelCSV()
  }
  
  override func viewDidDisappear() {
    super.viewDidDisappear()
    mergeCSV()
    saveLabelCSV()
    allLabels = [String: TileType]()
    tileLabels = [String: TileType]()
    classifier.clearSelection()
    popupClassifier.selectItem(at: 0)
    popupClassifier.title = popupClassifier.titleOfSelectedItem!
    imageView.image = nil
    currentIndex = 0
  }
  
  // MARK: - Selectors
  
  @objc func classifyImage() {
    if currentIndex >= tileLabels.count || currentIndex < 0 {
      return
    }

    let key = Array<String>(tileLabels.keys)[currentIndex]
    tileLabels[key] = classifier.selectedType
    nextImage()
  }
  
  @objc func nextImage() {
    currentIndex += 1
    showCurrentImage()
  }
  
  @objc func previousImage() {
    currentIndex -= 1
    showCurrentImage()
  }
  
  @objc func classifierChanged() {
    popupClassifier.title = popupClassifier.titleOfSelectedItem!
    mergeCSV()
    filterCSV()
    
    currentIndex = 0
    showCurrentImage()
  }
  
  func showCurrentImage() {
    guard currentIndex < tileLabels.keys.count && currentIndex >= 0 else {
      return
    }
    
    let keys = Array<String>(tileLabels.keys)
    let imageURL = URL(fileURLWithPath: dataset.classifiedDirectory + keys[currentIndex])
    imageView.image = NSImage(byReferencing: imageURL).resize(newSize: imageView.frame.size)
    imagesRemainingLabel.stringValue = "\(currentIndex + 1) of \(tileLabels.count)"
    
    if let currentType = tileLabels[keys[currentIndex]] {
      classifier.selectedType = currentType
    }
  }
}

// MARK: - CSV I/O Methods.
extension TileCleanerViewController {
  /// Loads the CSV file into memory, so that it can be modified.
  private func loadLabelCSV() {
    let labels = dataset.loadLabelCSV()
    for (key, value) in labels {
      allLabels[key] = TileType(rawValue: value)!
    }
  }
  
  /// Save the updated labels to a CSV.
  private func saveLabelCSV() {
    var labels = [String: Int]()
    for (key, value) in allLabels {
      labels[key] = value.rawValue
    }
    
    dataset.saveLabelCSV(allLabels: labels)
  }
  
  /// Filters all of the labels in the CSV to only those that match the current type.
  private func filterCSV() {
    guard let activeType = TileType(rawValue: popupClassifier.indexOfSelectedItem) else {
      return
    }
    
    tileLabels = allLabels.filter({ (key, value) -> Bool in
      return value == activeType
    })
  }
  
  /// Merges the changes back into the CSV file.
  private func mergeCSV() {
    for (key, value) in tileLabels {
      allLabels[key] = value
    }
  }
}
