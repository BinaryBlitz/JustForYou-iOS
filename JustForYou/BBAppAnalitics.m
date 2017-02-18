#import "BBAppAnalitics.h"

#import <Google/Analytics.h>

static NSString *const BBErrorInitAssert = @"Use 'instance' instead.";

static NSString *const BBAnaliticsJFYIdentifier = @"UA-92233966-1";

@implementation BBAppAnalitics

- (instancetype)init {
  NSAssert(NO, BBErrorInitAssert);
  return nil;
}

- (instancetype)initPrivate {
  return [super init];
}

+ (instancetype)sharedService {
  static BBAppAnalitics *instance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    instance = [[[self class] alloc] initPrivate];
  });
  return instance;
}

#pragma mark - Analitics Methods

- (void)sendControllerWithName:(NSString *)name {
  id <GAITracker> tracker = [[GAI sharedInstance] trackerWithTrackingId:BBAnaliticsJFYIdentifier];
  tracker.allowIDFACollection = YES;
  [tracker send:[[[GAIDictionaryBuilder createScreenView] set:name forKey:kGAIScreenName] build]];
}

- (void)sendUIActionWithCategory:(NSString *)category action:(NSString *)action label:(NSString *)label {
  id <GAITracker> tracker = [[GAI sharedInstance] trackerWithTrackingId:BBAnaliticsJFYIdentifier];
  tracker.allowIDFACollection = YES;
  [tracker send:[[GAIDictionaryBuilder createEventWithCategory:category action:action label:label value:nil] build]];
}

@end
