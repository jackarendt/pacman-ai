import Cocoa

/// View controller for manipulating the agent's learning and performance settings.
class AgentSettingsViewController: NSViewController {
  
  lazy var launchAIButton = {
    NSButton(title: "Launch AI", target: self, action: #selector(launchAI))
  }()

  let saveImagesSetting =
      CheckboxSettingCell(title: "Save unknown images", identifier: kSaveUnknownImagesKey)
  
  let saveOCRSetting =
      CheckboxSettingCell(title: "Save all text images", identifier: kSaveAllTextImagesKey)
  
  let confidenceThresholdSetting =
      NumericalInputSettingCell(title: "Minimum classification confidence",
                                identifier: kClassificationConfidenceThresholdKey)
  
  let randomSamplePercentage =
      NumericalInputSettingCell(title: "Random image sampling ratio",
                                identifier: kRandomImageSamplingFrequencyKey)
  
  let debugTextView = TileDebugTextView(frame: CGRect.zero)
  
  let stackView = NSStackView()
  
  private let margin: CGFloat = 20

  override func viewDidLoad() {
    super.viewDidLoad()
    
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.alignment = .leading
    stackView.spacing = 10
    view.addSubview(stackView)
    
    stackView.activateFullWidthAndHeightConstraints(padding: 20)
    
    addArrangedSubview(view: launchAIButton)
    addArrangedSubview(view: saveImagesSetting)
    addArrangedSubview(view: saveOCRSetting)
    addArrangedSubview(view: confidenceThresholdSetting)
    addArrangedSubview(view: randomSamplePercentage)
    
    debugTextView.translatesAutoresizingMaskIntoConstraints = false
    stackView.addArrangedSubview(debugTextView)
    debugTextView.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
  }
  
  @objc func launchAI() {
    if ApplicationManager.current.open() {
      print("Application Opened")
    } else {
      // TODO: Show an error message.
      print("OpenEmu not installed.")
    }
  }

  private func addArrangedSubview(view: NSView) {
    stackView.addArrangedSubview(view)
    view.translatesAutoresizingMaskIntoConstraints = false
    view.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
    view.heightAnchor.constraint(equalToConstant: 25).isActive = true
  }
}

