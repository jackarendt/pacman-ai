import Foundation

/// Protocol for a view that manages the agent's settings.
protocol SettingsCell {
  associatedtype T
  
  init(title: String, identifier: String)
  
  /// The key that is used to store and retrieve the setting.
  var settingsIdentifier: String { get }
  
  /// The value of the setting. Conforming classes should specify the type.
  var value: T { get set }
}
