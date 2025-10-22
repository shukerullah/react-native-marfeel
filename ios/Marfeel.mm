#import "Marfeel.h"

@implementation Marfeel

// Marfeel SDK methods will be implemented here

- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:
    (const facebook::react::ObjCTurboModule::InitParams &)params
{
    return std::make_shared<facebook::react::NativeMarfeelSpecJSI>(params);
}

+ (NSString *)moduleName
{
  return @"Marfeel";
}

@end
