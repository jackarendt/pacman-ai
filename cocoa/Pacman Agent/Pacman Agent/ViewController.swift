import Cocoa

class ViewController: NSViewController {
  
  let launchAIButton = NSButton(title: "Launch AI", target: self, action: #selector(launchAI))
  
  let debugImagePreview = NSImageView()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.widthAnchor.constraint(equalToConstant: 600).isActive = true
    view.heightAnchor.constraint(equalToConstant: 600).isActive = true
    
    view.addSubview(launchAIButton)
    launchAIButton.translatesAutoresizingMaskIntoConstraints = false
    launchAIButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
    launchAIButton.widthAnchor.constraint(equalToConstant: 75).isActive = true
    launchAIButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    launchAIButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
    
    view.addSubview(debugImagePreview)
    debugImagePreview.imageScaling = .scaleProportionallyDown
    debugImagePreview.translatesAutoresizingMaskIntoConstraints = false
    debugImagePreview.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
    debugImagePreview.leadingAnchor.constraint(equalTo: launchAIButton.trailingAnchor,
                                               constant: 20).isActive = true
    debugImagePreview.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                constant: -20).isActive = true
    debugImagePreview.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                              constant: -20).isActive = true
  }

  override var representedObject: Any? {
    didSet {
    // Update the view, if already loaded.
    }
  }
  
  @objc func launchAI() {
    ApplicationManager.current.delegate = self
    if ApplicationManager.current.open() {
      print("Application Opened")
    } else {
      print("OpenEmu not installed.")
    }
  }
}

extension ViewController: ApplicationManagerDelegate {
  func didUpdateWindowCapture(window: NSImage) {
    debugImagePreview.image = window
  }
}

