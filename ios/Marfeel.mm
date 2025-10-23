#import "Marfeel.h"
#import "Marfeel-Swift.h"

@implementation Marfeel

RCT_EXPORT_MODULE()

// Initialization
RCT_EXPORT_METHOD(initialize:(NSString *)accountId
                  pageTechnology:(nullable NSNumber *)pageTechnology)
{
    int accountIdInt = [accountId intValue];
    [MarfeelBridge initializeTrackerWithAccountId:accountIdInt pageTechnology:pageTechnology];
}

// Page & Screen Tracking
RCT_EXPORT_METHOD(trackNewPage:(NSString *)url
                  recirculationSource:(nullable NSString *)recirculationSource)
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSURL *nsUrl = [NSURL URLWithString:url];
        [MarfeelBridge trackNewPageWithUrl:nsUrl recirculationSource:recirculationSource];
    });
}

RCT_EXPORT_METHOD(trackScreen:(NSString *)screen
                  recirculationSource:(nullable NSString *)recirculationSource)
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MarfeelBridge trackScreenWithName:screen recirculationSource:recirculationSource];
    });
}

RCT_EXPORT_METHOD(stopTracking)
{
    [MarfeelBridge stopTracking];
}

RCT_EXPORT_METHOD(setLandingPage:(NSString *)landingPage)
{
    NSURL *landingPageUrl = [NSURL URLWithString:landingPage];
    [MarfeelBridge setLandingPageWithLandingPage:landingPageUrl];
}

// User Identification
RCT_EXPORT_METHOD(setSiteUserId:(NSString *)userId)
{
    [MarfeelBridge setSiteUserIdWithUserId:userId];
}

RCT_EXPORT_SYNCHRONOUS_TYPED_METHOD(NSString *, getUserId)
{
    return [MarfeelBridge getUserId];
}

// User Journey
RCT_EXPORT_METHOD(setUserType:(NSString *)userType
                  customId:(nullable NSNumber *)customId)
{
    [MarfeelBridge setUserTypeWithUserType:userType customId:customId];
}

// User RFV
RCT_EXPORT_METHOD(getRFV:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject)
{
    [MarfeelBridge getRFVWithCompletion:^(NSString * _Nonnull rfv) {
        resolve(rfv);
    }];
}

// Conversions
RCT_EXPORT_METHOD(trackConversion:(NSString *)conversion)
{
    [MarfeelBridge trackConversionWithConversion:conversion];
}

// Consent
RCT_EXPORT_METHOD(setConsent:(BOOL)hasConsent)
{
    [MarfeelBridge setConsentWithValue:hasConsent];
}

// Custom Dimensions - Page Vars
RCT_EXPORT_METHOD(setPageVar:(NSString *)name
                  value:(NSString *)value)
{
    [MarfeelBridge setPageVarWithName:name value:value];
}

// Custom Dimensions - Session Vars
RCT_EXPORT_METHOD(setSessionVar:(NSString *)name
                  value:(NSString *)value)
{
    [MarfeelBridge setSessionVarWithName:name value:value];
}

// Custom Dimensions - User Vars
RCT_EXPORT_METHOD(setUserVar:(NSString *)name
                  value:(NSString *)value)
{
    [MarfeelBridge setUserVarWithName:name value:value];
}

// User Segments
RCT_EXPORT_METHOD(addUserSegment:(NSString *)segment)
{
    [MarfeelBridge addUserSegmentWithSegment:segment];
}

RCT_EXPORT_METHOD(setUserSegments:(NSArray<NSString *> *)segments)
{
    [MarfeelBridge setUserSegmentsWithSegments:segments];
}

RCT_EXPORT_METHOD(removeUserSegment:(NSString *)segment)
{
    [MarfeelBridge removeUserSegmentWithSegment:segment];
}

RCT_EXPORT_METHOD(clearUserSegments)
{
    [MarfeelBridge clearUserSegments];
}

// Custom Metrics
RCT_EXPORT_METHOD(setPageMetric:(NSString *)metric
                  value:(NSNumber *)value)
{
    [MarfeelBridge setPageMetricWithName:metric value:[value intValue]];
}

// Multimedia Tracking
RCT_EXPORT_METHOD(initializeMultimediaItem:(NSString *)itemId
                  provider:(NSString *)provider
                  providerId:(NSString *)providerId
                  type:(NSString *)type
                  metadata:(NSDictionary *)metadata)
{
    [MarfeelBridge initializeMultimediaItemWithId:itemId
                                          provider:provider
                                        providerId:providerId
                                              type:type
                                          metadata:metadata];
}

RCT_EXPORT_METHOD(registerMultimediaEvent:(NSString *)itemId
                  event:(NSString *)event
                  eventTime:(NSNumber *)eventTime)
{
    [MarfeelBridge registerMultimediaEventWithId:itemId
                                           event:event
                                       eventTime:[eventTime intValue]];
}

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
