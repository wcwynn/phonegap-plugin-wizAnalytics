/* wizAnalytics - Localytics Module
 *
 * @author Ally Ogilvie
 * @copyright WizCorp Inc. [ Incorporated Wizards ] 2012
 * @file ModuleLocalytics.m for iOS
 *
 *
 */

#import "ModuleLocalytics.h"
#import "LocalyticsSession.h"
#import "WizDebugLog.h"

@interface ModuleLocalytics ()
@property (nonatomic, retain) NSString *localyticsAPIKey;
@end

@implementation ModuleLocalytics

- (void)dealloc
{
    self.localyticsAPIKey = nil;
    [super dealloc];
}

#pragma mark - Required WizAnalyticsVendorModule protocol methods

- (id)initWithOptions:(NSDictionary *)options
{
    if ((self = [super init])) {
        self.localyticsAPIKey = [options objectForKey:@"LocalyticsKey"];
    }
    return self;
}

- (void)startSession 
{
    WizLog(@"LOCALYTICS START SESSION %@", _localyticsAPIKey);
    [[LocalyticsSession sharedLocalyticsSession] startSession:_localyticsAPIKey];
}

#pragma mark - Optional WizAnalyticsVendorModule protocol methods

- (void)pauseSession
{
    [self stopSession];
}

- (void)stopSession
{
    [[LocalyticsSession sharedLocalyticsSession] close];
    [[LocalyticsSession sharedLocalyticsSession] upload];
}

- (void)resumeSession
{
    [[LocalyticsSession sharedLocalyticsSession] resume];
    [[LocalyticsSession sharedLocalyticsSession] upload];
}

- (void)logEvent:(NSString *)eventName withExtraMetadata:(NSDictionary *)extraMetadata
{
    WizLog(@"LOCALYTICS LOG EVENT %@ DATA %@", eventName, extraMetadata);
    [[LocalyticsSession sharedLocalyticsSession] tagEvent:eventName attributes:extraMetadata];
}

- (void)logScreen:(NSString *)screenName withExtraMetadata:(NSDictionary *)extraMetadata
{
    WizLog(@"LOCALYTICS LOG SCREEN %@", screenName);
    [[LocalyticsSession sharedLocalyticsSession] tagScreen:screenName];
}

@end