#import "TensorFlowUtilities.h"

#include <tensorflow/core/lib/core/status.h>

const std::string kModelName = "finalized_model.pb";

@implementation TensorFlowUtilities

static tensorflow::Session *kSession = NULL;

+ (tensorflow::Session *)createSessionIfNecessary {
  tensorflow::SessionOptions session_options;
  
  tensorflow::Status session_status = tensorflow::NewSession(session_options, &kSession);
  if (!session_status.ok()) {
    NSLog(@"Session create failed - %s", session_status.ToString().c_str());
    return NULL;
  }
  return kSession;
}

+ (void)endSession {
  if (kSession != nullptr) {
    delete kSession;
  }
}

+ (tensorflow::Status)loadGraphDef:(tensorflow::GraphDef &)graphDef
fromDirectory:(NSString *)modelDirectory {
  const std::string model_dir = std::string([modelDirectory UTF8String]);
  
  tensorflow::Status status;
  status = ReadBinaryProto(tensorflow::Env::Default(), model_dir + kModelName, &graphDef);
  if (!status.ok()) {
    NSLog(@"Error creating graph - %s", status.ToString().c_str());
  }
  return status;
}

+ (tensorflow::Tensor *)inputTensorFromPixelBuffer:(const PixelComponent *)pixelBuffer
                                  numberOfExamples:(NSInteger)examples {
  NSInteger imageBufferLength = kGameTileSize.width * kGameTileSize.height * kSamplesPerPixel;
  
  tensorflow::TensorShape shape({examples, imageBufferLength});
  tensorflow::Tensor *input = new tensorflow::Tensor(tensorflow::DT_FLOAT, shape);
  
  // input_tensor_mapped is an interface to the data of a tensor and used to copy data into the
  // tensor.
  auto input_tensor_mapped = input->tensor<float, 2>();
  
  // Map each item in the pixel buffer to the 2D input tensor.
  for (NSInteger i = 0; i < examples; i++) {
    for (NSInteger j = 0; j < imageBufferLength; j++) {
      input_tensor_mapped(i, j) = pixelBuffer[i * imageBufferLength + j];
    }
  }
  return input;
}

@end
