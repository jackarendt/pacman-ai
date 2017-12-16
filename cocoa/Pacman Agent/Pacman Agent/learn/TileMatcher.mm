#import "TileMatcher.h"

#include <tensorflow/core/lib/core/status.h>
#include <tensorflow/core/public/session.h>
#include <tensorflow/core/protobuf/meta_graph.pb.h>

using namespace std;
using namespace tensorflow;

const string kModelName = "model.meta";

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
  
  string model_dir = std::string([modelDirectory UTF8String]);
  
  SessionOptions session_options;
  Status status;
  
  Status session_status = NewSession(session_options, &session_);
  if (!session_status.ok()) {
    std::string status_string = session_status.ToString();
    NSLog(@"Session create failed - %s", status_string.c_str());
    return NO;
  }
  
  MetaGraphDef graph_def;
  status = ReadBinaryProto(Env::Default(), model_dir + kModelName, &graph_def);
  
  if (!status.ok()) {
    return NO;
  }

  status = session_->Create(graph_def.graph_def());
  if (!status.ok()) {
    cout << "Error creating graph: " + status.ToString() << endl;
    return NO;
  }
  
  return YES;
}

@end
