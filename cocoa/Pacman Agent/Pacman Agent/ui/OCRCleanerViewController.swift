import Cocoa

class OCRCleanerViewController: NSViewController {
  /// Button to classify an image.
  lazy var classifyImageButton = {
    return NSButton(title: "Fix Classification", target: self, action: #selector(classifyImage))
  }()
  
  /// Image view for showing an image.
  let imageView = NSImageView()
  
  /// Label for showing the image metadata.
  let descriptionLabel = NSTextField.label()
  
  let inputTextField = NSTextField()
  
  var labels = [String : Int]()
  var currentIndex = 0
  
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
    
    classifyImageButton.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(classifyImageButton)
    classifyImageButton.activateFullWidthConstraints(padding: padding)
    classifyImageButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
    classifyImageButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,
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
    let oIndex = kOCRValidCharacters.index(of: "o")
    let zeroIndex = kOCRValidCharacters.index(of: "0")
    guard oIndex != NSNotFound && zeroIndex != NSNotFound else {
      return
    }
    
    let allLabels = dataset.loadLabelCSV()
    labels = allLabels.filter({ $1 == oIndex || $1 == zeroIndex })
    currentIndex = 0
    showCurrentImage()
  }
  
  override func viewDidDisappear() {
    super.viewDidDisappear()
    var allLabels = dataset.loadLabelCSV()
    for (key, value) in labels {
      allLabels[key] = value
    }
    
    dataset.saveLabelCSV(allLabels: allLabels)
    imageView.image = nil
    currentIndex = 0
  }
  
  @objc func classifyImage() {
    if currentIndex >= labels.count || currentIndex < 0 {
      return
    }
    
    let index = kOCRValidCharacters.index(of: inputTextField.stringValue)
    guard index != NSNotFound else {
      return
    }
    
    let key = Array<String>(labels.keys)[currentIndex]
    labels[key] = index
    nextImage()
  }
  
  func nextImage() {
    currentIndex += 1
    showCurrentImage()
  }
  
  func showCurrentImage() {
    guard currentIndex < labels.keys.count && currentIndex >= 0 else {
      return
    }
    
    let keys = Array<String>(labels.keys)
    let imageURL = URL(fileURLWithPath: dataset.classifiedDirectory + keys[currentIndex])
    imageView.image = NSImage(byReferencing: imageURL).resize(newSize: imageView.frame.size)
    descriptionLabel.stringValue = "\(currentIndex + 1) of \(labels.count)"
    
    if let index = labels[keys[currentIndex]] {
      inputTextField.stringValue = kOCRValidCharacters.object(at: index) as! String
    }
  }
}
