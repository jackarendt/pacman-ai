import Cocoa

class UDPSocketRequest {
  
  let gameTiles: [GameTile]
  
  init(gameTiles: [GameTile]) {
    self.gameTiles = gameTiles
  }
  
  func serialize() -> UnsafePointer<UInt8>? {
    return UnsafePointer<UInt8>(bitPattern: 0)
  }
}
