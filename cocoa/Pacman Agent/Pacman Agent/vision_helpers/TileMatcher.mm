#import "TileMatcher.h"

#include <tensorflow/core/framework/tensor.h>
#include <tensorflow/core/lib/core/status.h>
#include <tensorflow/core/public/session.h>
#include <tensorflow/core/protobuf/meta_graph.pb.h>

const std::string kModelName = "finalized_model.pb";

@implementation TileMatcher {
  tensorflow::Session *session_;
}

- (void)dealloc {
  if (session_ != nullptr) {
    delete session_;
  }
}

- (BOOL)loadVisionModel {
  NSString *documentsDirectory =
      NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
  NSString *modelDirectory =
      [documentsDirectory stringByAppendingString:@"/pacman/vision/model/"];
  
  const std::string model_dir = std::string([modelDirectory UTF8String]);
  
  tensorflow::SessionOptions session_options;
  
  tensorflow::Status session_status = tensorflow::NewSession(session_options, &session_);
  if (!session_status.ok()) {
    NSLog(@"Session create failed - %s", session_status.ToString().c_str());
    return NO;
  }
  
  tensorflow::GraphDef graph_def;
  tensorflow::Status status;
  status = ReadBinaryProto(tensorflow::Env::Default(), model_dir + kModelName, &graph_def);
  if (!status.ok()) {
    NSLog(@"Error creating graph - %s", status.ToString().c_str());
    return NO;
  }

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
  NSInteger imageBufferLength = kGameTileSize.width * kGameTileSize.height * kSamplesPerPixel;
  NSInteger examples = kGameTileWidth * kGameTileHeight;
  tensorflow::Tensor input(tensorflow::DT_FLOAT,
                           tensorflow::TensorShape({examples, imageBufferLength}));
  
  // input_tensor_mapped is an interface to the data of a tensor and used to copy data into the
  // tensor.
  auto input_tensor_mapped = input.tensor<float, 2>();
  
  // Map each item in the pixel buffer to the 2D input tensor.
  for (NSInteger i = 0; i < examples; i++) {
    for (NSInteger j = 0; j < imageBufferLength; j++) {
      if (i == 646 && j == 95) {

      }
      input_tensor_mapped(i, j) = pixelBuffer[i * imageBufferLength + j];
    }
  }
  
  std::string output_name = "prediction/prediction:0";
  std::vector<tensorflow::Tensor> out_tensors;
  
  // Run inference on the input tensor.
  tensorflow::Status status;
  status = session_->Run({{"input/x-input:0", input}}, {output_name}, {}, &out_tensors);
  
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
      buffer[i] = (TileType)0;
    } else {
      buffer[i] = (TileType)max_index;
    }
  }
}

@end
