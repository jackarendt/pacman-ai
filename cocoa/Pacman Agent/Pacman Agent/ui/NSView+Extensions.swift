import Foundation

extension NSView {
  /// Pins the view to its superview.
  /// - param: padding The padding from the superview's bounds.
  func activateFullWidthAndHeightConstraints(padding: CGFloat) {
    activateFullHeightConstraints(padding: padding)
    activateFullWidthConstraints(padding: padding)
  }
  
  /// Pins the view's height to its superview.
  func activateFullHeightConstraints(padding: CGFloat) {
    guard let superview = superview else {
      return
    }
    
    topAnchor.constraint(equalTo: superview.topAnchor, constant: padding).isActive = true
    bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -padding).isActive = true
  }
  
  /// Pins the view's width to its superview.
  func activateFullWidthConstraints(padding: CGFloat) {
    guard let superview = superview else {
      return
    }
    
    leadingAnchor.constraint(equalTo: superview.leadingAnchor,
                             constant: padding).isActive = true
    trailingAnchor.constraint(equalTo: superview.trailingAnchor,
                              constant: -padding).isActive = true
  }
}
