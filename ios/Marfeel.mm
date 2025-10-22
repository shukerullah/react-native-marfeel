#import "Marfeel.h"
#import <MarfeelSDK_iOS/MarfeelSDK_iOS-Swift.h>

@implementation Marfeel

// Initialization
RCT_EXPORT_METHOD(initialize:(NSString *)accountId
                  pageTechnology:(NSNumber * _Nullable)pageTechnology)
{
    int accountIdInt = [accountId intValue];

    if (pageTechnology != nil) {
        [CompassTracker initializeWithAccountId:accountIdInt pageTechnology:[pageTechnology intValue] endpoint:nil];
    } else {
        [CompassTracker initializeWithAccountId:accountIdInt pageTechnology:nil endpoint:nil];
    }
}

// Page & Screen Tracking
RCT_EXPORT_METHOD(trackNewPage:(NSString *)url
                  recirculationSource:(NSString * _Nullable)recirculationSource)
{
    NSURL *nsUrl = [NSURL URLWithString:url];
    [[CompassTracker shared] trackNewPageWithUrl:nsUrl rs:recirculationSource];
}

RCT_EXPORT_METHOD(trackScreen:(NSString *)screen
                  recirculationSource:(NSString * _Nullable)recirculationSource)
{
    [[CompassTracker shared] trackScreenWithName:screen rs:recirculationSource];
}

RCT_EXPORT_METHOD(stopTracking)
{
    [[CompassTracker shared] stopTracking];
}

RCT_EXPORT_METHOD(setLandingPage:(NSString *)landingPage)
{
    NSURL *landingPageUrl = [NSURL URLWithString:landingPage];
    [[CompassTracker shared] setLandingPageWithLandingPage:landingPageUrl];
}

// User Identification
RCT_EXPORT_METHOD(setSiteUserId:(NSString *)userId)
{
    [[CompassTracker shared] setSiteUserIdWithUserId:userId];
}

RCT_EXPORT_SYNCHRONOUS_TYPED_METHOD(NSString *, getUserId)
{
    return [[CompassTracker shared] getUserId];
}

// User Journey
RCT_EXPORT_METHOD(setUserType:(NSString *)userType
                  customId:(NSNumber * _Nullable)customId)
{
    NSString *lowerUserType = [userType lowercaseString];

    if ([lowerUserType isEqualToString:@"anonymous"]) {
        [[CompassTracker shared] setUserType:UserTypeAnonymous];
    } else if ([lowerUserType isEqualToString:@"logged"]) {
        [[CompassTracker shared] setUserType:UserTypeLogged];
    } else if ([lowerUserType isEqualToString:@"paid"]) {
        [[CompassTracker shared] setUserType:UserTypePaid];
    } else if ([lowerUserType isEqualToString:@"custom"] && customId != nil) {
        [[CompassTracker shared] setUserType:[UserType customWithInt:[customId intValue]]];
    } else {
        [[CompassTracker shared] setUserType:UserTypeAnonymous];
    }
}

// User RFV
RCT_EXPORT_METHOD(getRFV:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject)
{
    [[CompassTracker shared] getRFVWithCompletion:^(NSString * _Nonnull rfv) {
        resolve(rfv);
    }];
}

// Conversions
RCT_EXPORT_METHOD(trackConversion:(NSString *)conversion)
{
    [[CompassTracker shared] trackConversionWithConversion:conversion];
}

// Consent
RCT_EXPORT_METHOD(setConsent:(BOOL)hasConsent)
{
    [[CompassTracker shared] setConsentWithValue:hasConsent];
}

// Custom Dimensions - Page Vars
RCT_EXPORT_METHOD(setPageVar:(NSString *)name
                  value:(NSString *)value)
{
    [[CompassTracker shared] setPageVarWithName:name value:value];
}

// Custom Dimensions - Session Vars
RCT_EXPORT_METHOD(setSessionVar:(NSString *)name
                  value:(NSString *)value)
{
    [[CompassTracker shared] setSessionVarWithName:name value:value];
}

// Custom Dimensions - User Vars
RCT_EXPORT_METHOD(setUserVar:(NSString *)name
                  value:(NSString *)value)
{
    [[CompassTracker shared] setUserVarWithName:name value:value];
}

// User Segments
RCT_EXPORT_METHOD(addUserSegment:(NSString *)segment)
{
    [[CompassTracker shared] addUserSegmentWithSegment:segment];
}

RCT_EXPORT_METHOD(setUserSegments:(NSArray<NSString *> *)segments)
{
    [[CompassTracker shared] setUserSegmentsWithSegments:segments];
}

RCT_EXPORT_METHOD(removeUserSegment:(NSString *)segment)
{
    [[CompassTracker shared] removeUserSegmentWithSegment:segment];
}

RCT_EXPORT_METHOD(clearUserSegments)
{
    [[CompassTracker shared] clearUserSegments];
}

// Custom Metrics
RCT_EXPORT_METHOD(setPageMetric:(NSString *)metric
                  value:(NSNumber *)value)
{
    [[CompassTracker shared] setPageMetricWithName:metric value:[value intValue]];
}

// Multimedia Tracking
RCT_EXPORT_METHOD(initializeMultimediaItem:(NSString *)itemId
                  provider:(NSString *)provider
                  providerId:(NSString *)providerId
                  type:(NSString *)type
                  metadata:(NSDictionary *)metadata)
{
    MediaType *mediaType;
    if ([[type lowercaseString] isEqualToString:@"audio"]) {
        mediaType = MediaTypeAUDIO;
    } else {
        mediaType = MediaTypeVIDEO;
    }

    MultimediaMetadata *multimediaMetadata = [[MultimediaMetadata alloc] init];

    if (metadata[@"isLive"] != nil) {
        multimediaMetadata.isLive = [metadata[@"isLive"] boolValue];
    }
    if (metadata[@"title"] != nil) {
        multimediaMetadata.title = metadata[@"title"];
    }
    if (metadata[@"description"] != nil) {
        multimediaMetadata.description = metadata[@"description"];
    }
    if (metadata[@"url"] != nil) {
        multimediaMetadata.url = [NSURL URLWithString:metadata[@"url"]];
    }
    if (metadata[@"thumbnail"] != nil) {
        multimediaMetadata.thumbnail = metadata[@"thumbnail"];
    }
    if (metadata[@"authors"] != nil) {
        multimediaMetadata.authors = metadata[@"authors"];
    }
    if (metadata[@"publishTime"] != nil) {
        multimediaMetadata.publishTime = [metadata[@"publishTime"] longLongValue];
    }
    if (metadata[@"duration"] != nil) {
        multimediaMetadata.duration = [metadata[@"duration"] intValue];
    }

    [[CompassTrackerMultimedia shared] initializeItemWithId:itemId
                                                    provider:provider
                                                  providerId:providerId
                                                        type:mediaType
                                                    metadata:multimediaMetadata];
}

RCT_EXPORT_METHOD(registerMultimediaEvent:(NSString *)itemId
                  event:(NSString *)event
                  eventTime:(NSNumber *)eventTime)
{
    NSString *lowerEvent = [event lowercaseString];
    MediaEvent *mediaEvent;

    if ([lowerEvent isEqualToString:@"play"]) {
        mediaEvent = MediaEventPLAY;
    } else if ([lowerEvent isEqualToString:@"pause"]) {
        mediaEvent = MediaEventPAUSE;
    } else if ([lowerEvent isEqualToString:@"end"]) {
        mediaEvent = MediaEventEND;
    } else if ([lowerEvent isEqualToString:@"updatecurrenttime"]) {
        mediaEvent = MediaEventUPDATE_CURRENT_TIME;
    } else if ([lowerEvent isEqualToString:@"adplay"]) {
        mediaEvent = MediaEventAD_PLAY;
    } else if ([lowerEvent isEqualToString:@"mute"]) {
        mediaEvent = MediaEventMUTE;
    } else if ([lowerEvent isEqualToString:@"unmute"]) {
        mediaEvent = MediaEventUNMUTE;
    } else if ([lowerEvent isEqualToString:@"fullscreen"]) {
        mediaEvent = MediaEventFULL_SCREEN;
    } else if ([lowerEvent isEqualToString:@"backscreen"]) {
        mediaEvent = MediaEventBACK_SCREEN;
    } else if ([lowerEvent isEqualToString:@"enterviewport"]) {
        mediaEvent = MediaEventENTER_VIEWPORT;
    } else if ([lowerEvent isEqualToString:@"leaveviewport"]) {
        mediaEvent = MediaEventLEAVE_VIEWPORT;
    } else {
        mediaEvent = MediaEventPLAY;
    }

    [[CompassTrackerMultimedia shared] registerEventWithId:itemId
                                                      event:mediaEvent
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
