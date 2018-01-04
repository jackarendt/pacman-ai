import Cocoa

protocol ClassificationSelectionViewDelegate: class {
  func selectionViewDidChange(selectionView: ClassificationSelectionView)
}

/// Control that allows a user to select what type of tile is being shown.
final class ClassificationSelectionView: NSControl {

  lazy var tileTypes: [TileType] = {
    var types = [TileType]()
    let typeBuffer = UnsafeMutablePointer<TileType>.allocate(capacity: kTileTypeCount)
    TileMatcher.allTileTypes(typeBuffer)
    
    for i in 0..<kTileTypeCount {
      types.append(typeBuffer[i])
    }
    typeBuffer.deallocate(capacity: Int(kTileTypeCount))
    return types
  }()
  
  var selectedType: TileType = .unknown {
    didSet {
      selectCurrentRadioButton()
    }
  }
  
  weak var delegate: ClassificationSelectionViewDelegate?
  
  private var radioButtons = [NSButton]()
  
  override init(frame frameRect: NSRect) {
    super.init(frame: frameRect)
    
    let stackView = NSStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.alignment = .top
    stackView.orientation = .horizontal
    stackView.spacing = 0
    stackView.distribution = .fillEqually
    
    let columns = 2
    let rows = kTileTypeCount / columns
    for column in stride(from: 0, to: columns, by: 1) {
      let columnStackView = NSStackView()
      columnStackView.translatesAutoresizingMaskIntoConstraints = false
      columnStackView.alignment = .left
      columnStackView.orientation = .vertical
      columnStackView.spacing = 0
      columnStackView.distribution = .equalSpacing
      
      for type in tileTypes[column * rows..<(column + 1) * rows] {
        let description = TileMatcher.description(for: type)
        let button = NSButton(radioButtonWithTitle: description!,
                              target: self,
                              action: #selector(radioButtonClicked(sender:)))
        button.tag = type.rawValue
        columnStackView.addArrangedSubview(button)
        button.activateFullWidthConstraints(padding: 0)
        button.heightAnchor.constraint(equalToConstant: 20).isActive = true
        radioButtons.append(button)
      }
      stackView.addArrangedSubview(columnStackView)
    }
    addSubview(stackView)
    stackView.activateFullWidthAndHeightConstraints(padding: 0)
  }
  
  required init?(coder decoder: NSCoder) {
    fatalError()
  }
  
  func clearSelection() {
    for button in radioButtons {
      button.state = .off
    }
    selectedType = .unknown
  }
  
  @objc func radioButtonClicked(sender: NSButton) {
    guard let type = TileType(rawValue: sender.tag - 1) else {
      return
    }
    
    selectedType = type
    delegate?.selectionViewDidChange(selectionView: self)
    selectCurrentRadioButton()
  }
  
  private func selectCurrentRadioButton() {
    for (idx, button) in radioButtons.enumerated() {
      if idx == selectedType.rawValue {
        button.state = .on
      } else {
        button.state = .off
      }
    }
  }
}
