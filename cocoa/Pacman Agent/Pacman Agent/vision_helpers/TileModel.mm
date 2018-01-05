#import "TileModel.h"
#import "TensorFlowUtilities.h"

#include <tensorflow/core/protobuf/meta_graph.pb.h>

@implementation TileModel {
  tensorflow::Session *session_;
}

- (void)dealloc {
  [TensorFlowUtilities endSession];
}

- (BOOL)loadTileModel {
  NSString *documentsDirectory =
      NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
  NSString *modelDirectory =
      [documentsDirectory stringByAppendingString:@"/pacman/vision/tile_model/"];
  
  session_ = [TensorFlowUtilities createSessionIfNecessary];
  if (!session_) {
    return NO;
  }
  
  tensorflow::GraphDef graph_def;
  tensorflow::Status status =
      [TensorFlowUtilities loadGraphDef:graph_def fromDirectory:modelDirectory];

  status = session_->Create(graph_def);
  if (!status.ok()) {
    NSLog(@"Error creating graph - %s", status.ToString().c_str());
    return NO;
  }
  return YES;
}

- (void)predictionsForTiles:(const PixelComponent *)pixelBuffer
                 tileBuffer:(enum TileType *)buffer
        confidenceThreshold:(float)threshold {
  if (!session_ || !buffer || !pixelBuffer) {
    NSLog(@"Error: cannot predict tiles."
          @"One of the following inputs is NULL, session_, buffer, pixelBuffer.");
    return;
  }
  
  // Create the input tensor.
  tensorflow::Tensor *input =
      [TensorFlowUtilities inputTensorFromPixelBuffer:pixelBuffer
                                     numberOfExamples:kGameTileHeight * kGameTileWidth];
  
  std::string output_name = "prediction/prediction:0";
  std::vector<tensorflow::Tensor> out_tensors;
  
  // Run inference on the input tensor.
  tensorflow::Status status;
  status = session_->Run({{"input/x-input:0", *input}}, {output_name}, {}, &out_tensors);
  
  // Remove input tensor.
  delete input;
  
  if (!status.ok()) {
    NSLog(@"Vision Inference Failed - %s", status.ToString().c_str());
    return;
  }
  
  tensorflow::Tensor output = out_tensors[0];
  auto output_tensor_mapped = output.tensor<float, 2>();
  
  for (int i = 0; i < output.shape().dim_size(0); i++) {
    NSInteger max_index = 0;
    float max_value = 0;
    for (int j = 0; j < output.shape().dim_size(1); j++) {
      float value = output_tensor_mapped(i, j);
      if (value > max_value) {
        max_index = j;
        max_value = value;
      }
    }
    
    if (max_value < threshold) {
      buffer[i] = TileTypeUnknown;
    } else {
      buffer[i] = (TileType)max_index;
    }
  }
}

@end
