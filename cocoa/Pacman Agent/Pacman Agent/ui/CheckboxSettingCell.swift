import Cocoa

/// Setting cell for a boolean setting.
class CheckboxSettingCell: NSView, SettingsCell {
  var settingsIdentifier: String
  
  var value: Bool {
    didSet {
      UserDefaults.standard.set(value, forKey: settingsIdentifier)
    }
  }
  
  var checkbox: NSButton!
  
  required init(title: String, identifier: String) {
    self.settingsIdentifier = identifier
    self.value = UserDefaults.standard.bool(forKey: settingsIdentifier)
    super.init(frame: NSRect.zero)
    
    translatesAutoresizingMaskIntoConstraints = false
    
    checkbox =
        NSButton(checkboxWithTitle: title, target: self, action: #selector(checkboxStateUpdated))
    checkbox.translatesAutoresizingMaskIntoConstraints = false
    checkbox.state = value ? .on : .off
    addSubview(checkbox)
    checkbox.activateFullWidthAndHeightConstraints(padding: 0)
  }
  
  required init?(coder decoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  @objc func checkboxStateUpdated() {
    value = checkbox.state == .on
  }
}
