import Cocoa

/// Setting cell for inputting numerical text.
class NumericalInputSettingCell: NSView, SettingsCell {
  var settingsIdentifier: String
  
  var value: Int {
    didSet {
      UserDefaults.standard.set(value, forKey: settingsIdentifier)
    }
  }
  
  let label = NSTextField.label()
  let textInput = NSTextField(frame: CGRect.zero)
  
  required init(title: String, identifier: String) {
    self.settingsIdentifier = identifier
    self.value = UserDefaults.standard.integer(forKey: settingsIdentifier)
    super.init(frame: CGRect.zero)
    
    label.translatesAutoresizingMaskIntoConstraints = false
    label.stringValue = title
    label.font = NSFont.systemFont(ofSize: 13)
    addSubview(label)
    
    textInput.translatesAutoresizingMaskIntoConstraints = false
    textInput.placeholderString = "1"
    textInput.stringValue = value > 0 ? String(value) : ""
    textInput.refusesFirstResponder = true
    textInput.delegate = self
    addSubview(textInput)
    
    label.activateFullHeightConstraints(padding: 0)
    textInput.activateFullHeightConstraints(padding: 0)
    
    textInput.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    textInput.widthAnchor.constraint(equalToConstant: 30).isActive = true
    label.leadingAnchor.constraint(equalTo: textInput.trailingAnchor, constant: 10).isActive = true
    label.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
  }
  
  required init?(coder decoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension NumericalInputSettingCell: NSTextFieldDelegate {
  override func controlTextDidChange(_ obj: Notification) {
      value = textInput.integerValue
  }
}
