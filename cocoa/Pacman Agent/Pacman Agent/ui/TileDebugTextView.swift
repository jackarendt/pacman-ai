//
//  TileDebugTextView.swift
//  Pacman Agent
//
//  Created by Jack Arendt on 12/19/17.
//  Copyright © 2017 Jack Arendt. All rights reserved.
//

import Cocoa

class TileDebugTextView: NSTextView {
  override init(frame frameRect: NSRect) {
    super.init(frame: frameRect)
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(updateTextView(notification:)),
                                           name: kDidUpdateWindowCaptureNotification,
                                           object: nil)
    
    font = NSFont(name: "Menlo-Regular", size: 10)
    isEditable = false
    isSelectable = false
    maxSize = CGSize(width: CGFloat.greatestFiniteMagnitude,
                     height: CGFloat.greatestFiniteMagnitude)
    minSize = CGSize(width: 260, height: 550)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(frame frameRect: NSRect, textContainer container: NSTextContainer?) {
    super.init(frame: frameRect, textContainer: container)
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
  @objc func updateTextView(notification: Notification) {
    if let description = notification.object as? String {
      string = description
    }
  }
}
