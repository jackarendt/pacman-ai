#import <Foundation/Foundation.h>

typedef NS_ENUM(uint16_t, SimulatedKeyCode) {
  SimulatedKeyCodeNone = 0,
  SimulatedKeyCodeLeftArrow = 1,
  SimulatedKeyCodeRightArrow = 2,
  SimulatedKeyCodeDownArrow = 3,
  SimulatedKeyCodeUpArrow = 4,
  SimulatedKeyCodeEnter = 5,
  SimulatedKeyCodeRightShift = 6,
};

/** Helper methods for interfacing with the hardware. */
@interface HardwareInterface : NSObject

/** Simulates a key press on the keyboard. */
+ (void)simulateKeyPress:(SimulatedKeyCode)keyCode;

@end
