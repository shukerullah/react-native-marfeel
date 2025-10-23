#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(Marfeel, NSObject)

RCT_EXTERN_METHOD(initialize:(NSString *)accountId
                  pageTechnology:(NSNumber *)pageTechnology)

RCT_EXTERN_METHOD(trackNewPage:(NSString *)url
                  recirculationSource:(NSString *)recirculationSource)

RCT_EXTERN_METHOD(trackScreen:(NSString *)screen
                  recirculationSource:(NSString *)recirculationSource)

@end
