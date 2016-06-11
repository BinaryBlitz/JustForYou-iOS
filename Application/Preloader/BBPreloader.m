//
//  BBPreloader.m
//  JustForYou
//
//  Created by Антон on 19.03.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBPreloader.h"

#import "BBTabbarAssembly.h"
#import "BBTabbarModuleInput.h"

#import "BBNavigationAssembly.h"
#import "BBNavigationModuleInput.h"

#import <Realm/Realm.h>

#import "BBUserService.h"

@interface BBPreloader () <BBNavigationModuleOutput, BBTabbarModuleOutput>

@property (weak, nonatomic) UIWindow *window;

@property (strong, nonatomic) id<BBTabbarModuleInput> tabbarModule;
@property (strong, nonatomic) id<BBNavigationModuleInput> navigationModule;

@end

static NSInteger shemaVersionRealm = 6;

@implementation BBPreloader

-(instancetype)initWithWindow:(UIWindow *)window {
    self = [super init];
    if (self) {
        self.window = window;
        [self _migrationRealm];
        [self setCustomBackBarButtonImage];
        [self _setStartControllerToRoot];
    }
    return self;
}

- (void)_migrationRealm {
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    config.schemaVersion = shemaVersionRealm;
    config.migrationBlock = ^(RLMMigration *migration, uint64_t oldSchemaVersion) {
        // We haven’t migrated anything yet, so oldSchemaVersion == 0
        if (oldSchemaVersion < shemaVersionRealm) {
            // Nothing to do!
            // Realm will automatically detect new properties and removed properties
            // And will update the schema on disk automatically
        }
    };
    [RLMRealmConfiguration setDefaultConfiguration:config];
    [RLMRealm defaultRealm];
}

- (void)_setStartControllerToRoot {
    BBUser *user = [[BBUserService sharedService] currentUser];
    if (user) {
        [self.tabbarModule presentInWindow:self.window];
    } else {
        [self.navigationModule presentInWindow:self.window];
    }
}

#pragma mark - методы BBNavigationModuleOutput

- (void)userRegistrationFulfilled {
    UIViewController *vc = [self.tabbarModule currentView];
    __weak typeof(self)weakSelf = self;
    HQDispatchToMainQueue(^{
        [weakSelf.window setRootViewController:vc];
    });
}

- (void)userLogout {
    UIViewController *vc = [self.navigationModule currentViewWithLoadModule:BBRegistrationModule];
    __weak typeof(self)weakSelf = self;
    HQDispatchToMainQueue(^{
        [weakSelf.window setRootViewController:vc];
    });
}

- (void)setCustomBackBarButtonImage {
    [[UINavigationBar appearance] setBackIndicatorImage:[[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
//    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init]
//                       forBarPosition:UIBarPositionAny
//                           barMetrics:UIBarMetricsDefault];
//    
//    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
    
}

# pragma mark - Lazy Load

- (id<BBTabbarModuleInput>) tabbarModule {
    if (!_tabbarModule) {
        _tabbarModule = [BBTabbarAssembly createModule];
        _tabbarModule.output = self;
    }
    return _tabbarModule;
}

- (id<BBNavigationModuleInput>) navigationModule {
    if (!_navigationModule) {
        _navigationModule = [BBNavigationAssembly createModule];
        _navigationModule.output = self;
    }
    return _navigationModule;
}

@end
