#import <Foundation/Foundation.h>
#import "VisionConstants.h"

#include <tensorflow/core/framework/tensor.h>
#include <tensorflow/core/lib/core/status.h>
#include <tensorflow/core/public/session.h>
#include <tensorflow/core/protobuf/meta_graph.pb.h>

@interface TensorFlowUtilities : NSObject

+ (tensorflow::Session *)createSessionIfNecessary;

+ (void)endSession;

+ (tensorflow::Status)loadGraphDef:(tensorflow::GraphDef&)graphDef
                     fromDirectory:(NSString *)modelDirectory;

+ (tensorflow::Tensor *)inputTensorFromPixelBuffer:(const PixelComponent *)pixelBuffer
                                  numberOfExamples:(NSInteger)examples;

@end
