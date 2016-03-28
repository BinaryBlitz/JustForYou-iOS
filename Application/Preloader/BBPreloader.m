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

#import "BBAuthorizationAssembly.h"
#import "BBAuthorizationModuleInput.h"

#import "BBUserService.h"

@interface BBPreloader ()

@property (weak, nonatomic) UIWindow *window;

@property (nonatomic) id<BBTabbarModuleInput> tabbarModule;
@property (nonatomic) id<BBAuthorizationModuleInput> authorizationModule;

@end

@implementation BBPreloader

-(instancetype)initWithWindow:(UIWindow *)window {
    self = [super init];
    if (self) {
        self.window = window;
        if ([[BBUserService sharedService] currentUser]) {
            [self.tabbarModule presentInWindow:window];
        } else {
            [self.authorizationModule presentInWindow:window];
        }
    }
    return self;
}

# pragma mark - Lazy Load

- (id<BBTabbarModuleInput>) tabbarModule {
    if (!_tabbarModule) {
        _tabbarModule = [BBTabbarAssembly createModule];
    }
    return _tabbarModule;
}

- (id<BBAuthorizationModuleInput>) authorizationModule {
    if (!_authorizationModule) {
        _authorizationModule = [BBAuthorizationAssembly createModule];
    }
    return _authorizationModule;
}

@end
