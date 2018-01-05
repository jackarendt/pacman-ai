#import <Foundation/Foundation.h>
#import "VisionConstants.h"

@interface OCRModel : NSObject

- (BOOL)loadOCRModel;

- (void)predictionsForText:(const PixelComponent *)pixelBuffer
                textBuffer:(NSMutableArray<NSString *> *)textBuffer
          numberOfExamples:(NSInteger)examples
       confidenceThreshold:(float)threshold;

@end
