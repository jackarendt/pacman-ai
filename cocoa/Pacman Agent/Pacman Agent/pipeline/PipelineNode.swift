import Foundation

enum ExecutionStatus {
  case success
  case failure
}

/// Protocol for defining a node in the execution pipeline.
protocol PipelineNode: class {
  /// Identifiers of nodes that need to be completed before a node runs. If set to `nil`, it is
  /// considered an input node, and runs when the pipeline begins.
  var dependencyIdentifiers: [String]? { get set }
  
  /// Whether the node is enabled or not. If a node is disabled, it'll be dequeued in the pipeline,
  /// but `execute()` will not run.
  var enabled: Bool { get }
  
  /// Whether the node is an output node or not.
  var isOutput: Bool { get }
  
  /// The level at which the node is run.
  /// - Note: This is set by the pipeline. Do not override this value.
  var executionLevel: Int { get set }
  
  /// The identifier for a node.
  static var identifier: String { get }
  
  /// The local identifier of the node. This allows for direct comparison of nodes when analyzing.
  var localIdentifier: String { get }
  
  /// Executes the operation of the node. This needs to be performed
  func execute(_ input: [String: Any]) -> (output: Any, status: ExecutionStatus)
}
