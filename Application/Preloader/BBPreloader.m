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
#import "BBServerService.h"
#import "BBDataBaseService.h"

@interface BBPreloader () <BBNavigationModuleOutput, BBTabbarModuleOutput>

@property (weak, nonatomic) UIWindow *window;

@property (strong, nonatomic) id<BBTabbarModuleInput> tabbarModule;
@property (strong, nonatomic) id<BBNavigationModuleInput> navigationModule;

@end

static NSInteger shemaVersionRealm = 28;

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
        }
    };
    [RLMRealmConfiguration setDefaultConfiguration:config];
    [RLMRealm defaultRealm];
}

- (void)_setStartControllerToRoot {
    BBUser *user = [[BBUserService sharedService] currentUser];
    if (user) {
        [self _addPushNotification];
        [self.tabbarModule presentInWindow:self.window];
        [self _updateUserOnDataBase];
    } else {
        [self.navigationModule presentInWindow:self.window];
    }
}

- (void)_updateUserOnDataBase {
    [[BBServerService sharedService] showUserWithUserToken:[[BBUserService sharedService] tokenUser] completion:^(BBServerResponse *response, BBUser *user, NSError *error) {
        [[BBUserService sharedService] updateUserWithUser:user];
    }];
    [[BBServerService sharedService] listPaymentCardsUserWithApiToken:[[BBUserService sharedService] tokenUser] completion:^(BBServerResponse *response, NSArray *objects, NSError *error) {
        HQDispatchToMainQueue(^{
            [[BBDataBaseService sharedService] addOrUpdatePayCardsUserWithArray:objects];
        });
    }];
    [[BBServerService sharedService] listAddressUserWithApiToken:[[BBUserService sharedService] tokenUser] completion:^(BBServerResponse *response, NSArray *objects, NSError *error) {
        [[BBUserService sharedService] addAddressUserFromArray:objects];
    }];
}

- (void)_addPushNotification {
    [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
    
    [[UIApplication sharedApplication] registerForRemoteNotifications];
}

#pragma mark - методы BBNavigationModuleOutput

- (void)userRegistrationFulfilled {
    [self _addPushNotification];
    [self _migrationRealm];
    UIViewController *vc = [self.tabbarModule currentView];
    __weak typeof(self)weakSelf = self;
    HQDispatchToMainQueue(^{
        [weakSelf.window setRootViewController:vc];
    });
}

- (void)userLogout {
    [[BBUserService sharedService] logOutUser];
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
