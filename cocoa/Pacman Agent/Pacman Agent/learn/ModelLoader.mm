#import "ModelLoader.h"

#include "tensorflow/cc/saved_model/loader.h"
#include "tensorflow/cc/saved_model/tag_constants.h"
#include "tensorflow/core/lib/core/status.h"

using namespace std;
using namespace tensorflow;

@implementation ModelLoader

+ (void)loadVisionModel {
//  NSString *documentsDirectory =
      NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
  NSString *modelDirectory = [documentsDirectory stringByAppendingString:@"/pacman/vision/model"];
  
  string model_dir = std::string([modelDirectory UTF8String]);
  SavedModelBundle bundle;
  SessionOptions session_options;
  RunOptions run_options;
  
  unordered_set<string> tags;
  tags.insert(kSavedModelTagServe);
  
//  Status status = LoadSavedModel(session_options, run_options, model_dir, tags, &bundle);
//  if (status.ok()) {
//    NSLog(@"MODEL LOADED YAY");
//  } else {
//    NSLog(@"MODEL NOT LOADED BOO");
//  }
}

@end
