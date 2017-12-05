import Foundation

/// The type of game piece that a tile occupies.
enum GamePiece: Int, CustomStringConvertible {
  case unknown = 0
  case pacman = 1
  case wall = 2
  case blank = 3
  case fruit = 4
  case blinky = 5
  case inky = 6
  case pinky = 7
  case clyde = 8
  case frightenedGhost = 9
  case pellet = 10
  case powerPellet = 11
  
  var description: String {
    switch self {
    case .unknown: return "unknown"
    case .pacman: return "pacman"
    case .wall: return "wall"
    case .blank: return "blank"
    case .fruit: return "fruit"
    case .blinky: return "blinky"
    case .inky: return "inky"
    case .pinky: return "pinky"
    case .clyde: return "clyde"
    case .frightenedGhost: return "frightened ghost"
    case .pellet: return "pellet"
    case .powerPellet: return "power pellet"
    }
  }
}
