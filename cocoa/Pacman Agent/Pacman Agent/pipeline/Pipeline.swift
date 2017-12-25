import Foundation

/// General purpose class for executing a data processing pipeline.
/// Calling `initalizeWithNodes` initializes the pipeline for execution and also runs static analysis
class Pipeline {
  
  /// The rate at which the pipeline is run. If set to `0`, the pipeline will run once when
  /// `start()` is invoked. Otherwise, it will run continously until `stop()` is called.
  var refreshInterval: TimeInterval = 0.0
  
  /// Execution timer.
  private var timer: Timer?
  
  /// The nodes in the pipeline that should be executed.
  private var nodes = [PipelineNode]()
  
  /// Adds the nodes to the current execution graph and analyzes position.
  /// This loops through all of the nodes, and builds an execution graph from the bottom up. It
  /// first looks at the output nodes and gathers the dependent nodes. From there it continues to
  /// work upwards, creating a dependency graph until all nodes have been added to staging. Nodes
  /// are then sorted in descending order, so that the output nodes run last, and the nodes with no
  /// dependencies run first. This ensures a flexible, yet quick execution.
  func initializeWithNodes(nodes: [PipelineNode]) {
    var staging = [PipelineNode]()
    var level = 0
    
    /// Get the output nodes and add them to staging.
    var currentLevelNodes = nodes.filter { $0.isOutput }
    for output in currentLevelNodes {
      output.executionLevel = level
      staging.append(output)
    }
    
    while staging.count != nodes.count {
      level += 1
      // Get the dependencies from the previous level.
      let dependencies = dependencySet(nodes: currentLevelNodes)
      currentLevelNodes = nodes.filter { dependencies.contains(self.identifier(node: $0)) }
      
      // Loop through the nodes for the next level and assign the new level. Optionally add the
      // nodes to staging if they haven't been added before.
      for node in currentLevelNodes {
        node.executionLevel = level
        if !staging.contains(where: { self.identifier(node: $0) == self.identifier(node: node) }) {
          staging.append(node)
        }
      }
    }
    
    // Sort the nodes in descending order so that output nodes (low execution level) run last, and
    // the input nodes (high execution level) run first.
    self.nodes = staging.sorted(by: { $0.executionLevel > $1.executionLevel })
  }
  
  /// Starts pipeline execution. Execution will run once if the refresh interval is 0, otherwise it
  /// will run continuously until `stop()` is invoked, or the pipeline is deallocated.
  func start() {
    guard nodes.count > 0 else {
      print("Cannot start pipeline with no nodes.")
      return
    }

    if refreshInterval == 0 {
      execute()
    } else {
      timer = Timer.scheduledTimer(timeInterval: refreshInterval,
                                   target: self,
                                   selector: #selector(execute),
                                   userInfo: nil,
                                   repeats: true)
    }
  }
  
  func stop() {
    timer?.invalidate()
    timer = nil
  }
  
  /// Executes the pipeline from the beginning.
  @objc func execute() {
    // Run in an autorelease block in case this is run from a timer. Continous execution could cause
    // memory to balloon.
    autoreleasepool {
      var output = [String: Any]()
      for node in self.nodes {
        // Don't execute disabled nodes.
        if !node.enabled {
          continue
        }
        
        do {
          // Execute the node and add the output to the output directory.
          output[self.identifier(node: node)] = try node.execute(output)
        } catch {
          print("node \(self.identifier(node: node)) failed.\nHalting pipeline.")
          self.stop()
        }
      }
    }
  }
  
  /// Creates a set of all of the dependent nodes for a given execution level.
  private func dependencySet(nodes: [PipelineNode]) -> Set<String> {
    var dependencies = Set<String>()
    
    // Loop through the supplied nodes and add all of their dependencies to a set. The corresponding
    // nodes will be placed at least one level above this subset of nodes.
    for node in nodes {
      if let identifiers = node.dependencyIdentifiers {
        for identifier in identifiers {
          dependencies.insert(identifier)
        }
      }
    }
    return dependencies
  }
  
  private func identifier(node: PipelineNode) -> String {
    return type(of: node).identifier
  }
}
