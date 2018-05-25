#import "HardwareInterface.h"

#import <CoreGraphics/CoreGraphics.h>

@implementation HardwareInterface

+ (void)simulateKeyPress:(SimulatedKeyCode)keyCode {
  CGKeyCode virtualKey = [self keyCodeForSimulatedKeyCode:keyCode];
  
  CGEventSourceRef source = CGEventSourceCreate(kCGEventSourceStateCombinedSessionState);
  CGEventRef touchDown = CGEventCreateKeyboardEvent(source, virtualKey, YES);
  CGEventRef touchUp = CGEventCreateKeyboardEvent(source, virtualKey, NO);
  
  CGEventPost(kCGAnnotatedSessionEventTap, touchDown);
  CGEventPost(kCGAnnotatedSessionEventTap, touchUp);
  
  CFRelease(touchUp);
  CFRelease(touchDown);
  CFRelease(source);
}

+ (CGKeyCode)keyCodeForSimulatedKeyCode:(SimulatedKeyCode)keyCode {
  switch (keyCode) {
    case SimulatedKeyCodeNone:
      return 0;
    case SimulatedKeyCodeLeftArrow:
      return 123;
    case SimulatedKeyCodeRightArrow:
      return 124;
    case SimulatedKeyCodeDownArrow:
      return 125;
    case SimulatedKeyCodeUpArrow:
      return 126;
    case SimulatedKeyCodeEnter:
      return 76;
    case SimulatedKeyCodeRightShift:
      return 60;
  }
}

@end
