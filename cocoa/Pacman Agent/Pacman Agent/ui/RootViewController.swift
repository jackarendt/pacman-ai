import Cocoa

class RootViewController: NSViewController {
  
  let launchAIButton = NSButton(title: "Launch AI", target: self, action: #selector(launchAI))
  
  let classifyImagesButton =
    NSButton(title: "Classify Images", target: self, action: #selector(classifyImages))
  
  let stackView = NSStackView()
  

  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.translatesAutoresizingMaskIntoConstraints = false
    view.widthAnchor.constraint(equalToConstant: 350).isActive = true
    view.heightAnchor.constraint(equalToConstant: 500).isActive = true
    
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.alignment = .leading
    stackView.spacing = 10
    view.addSubview(stackView)
    
    stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
    stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
    stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
    stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    
    
    stackView.addArrangedSubview(launchAIButton)
    launchAIButton.translatesAutoresizingMaskIntoConstraints = false
    launchAIButton.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
    launchAIButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
  }

  override var representedObject: Any? {
    didSet {
    // Update the view, if already loaded.
    }
  }
  
  @objc func launchAI() {
    if ApplicationManager.current.open() {
      print("Application Opened")
    } else {
      print("OpenEmu not installed.")
    }
  }
  
  @objc func classifyImages() {
    
  }
}

