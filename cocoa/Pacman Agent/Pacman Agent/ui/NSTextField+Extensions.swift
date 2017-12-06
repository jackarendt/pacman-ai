import Foundation

extension NSTextField {
  /// Creates a non-editable label that mimics the behavior of UILabel.
  class func label() -> NSTextField {
    return label(text: "")
  }
  
  /// Creates a non-editable label that mimics the behavior of UILabel.
  /// - param: text The text of the label.
  class func label(text: String) -> NSTextField {
    let textField = NSTextField(frame: CGRect.zero)
    textField.stringValue = text
    textField.isBezeled = false
    textField.drawsBackground = false
    textField.isEditable = false
    textField.isSelectable = false
    return textField
  }
}
