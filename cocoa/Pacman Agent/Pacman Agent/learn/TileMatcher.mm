#import "TileMatcher.h"

#include <tensorflow/core/lib/core/status.h>
#include <tensorflow/core/public/session.h>
#include <tensorflow/core/protobuf/meta_graph.pb.h>

using namespace std;
using namespace tensorflow;

const string kModelName = "finalized_model.pb";

@implementation TileMatcher {
  Session *session_;
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
  
  const string model_dir = std::string([modelDirectory UTF8String]);
  
  SessionOptions session_options;
  
  Status session_status = NewSession(session_options, &session_);
  if (!session_status.ok()) {
    NSLog(@"Session create failed - %s", session_status.ToString().c_str());
    return NO;
  }
  
  GraphDef graph_def;
  Status status;
  status = ReadBinaryProto(Env::Default(), model_dir + kModelName, &graph_def);
  if (!status.ok()) {
    cout << "Error creating graph: " + status.ToString() << endl;
    return NO;
  }

  status = session_->Create(graph_def);
  if (!status.ok()) {
    cout << "Error creating graph: " + status.ToString() << endl;
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
  
  // Convert this to a 2D vector of floats.
  // Create tensor.
  // Run inference.
  // Dealloc vector/tensor.
  // Check thresholds
  // Populate buffer of classifications.
}

@end
