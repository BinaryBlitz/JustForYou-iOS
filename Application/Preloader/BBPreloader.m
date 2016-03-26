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

#import "BBRegistrationAssembly.h"
#import "BBRegistrationModuleInput.h"

#import "BBUserService.h"

@interface BBPreloader ()

@property (weak, nonatomic) UIWindow *window;

@property (nonatomic) id<BBTabbarModuleInput> tabbarModule;
@property (nonatomic) id<BBRegistrationModuleInput> registrationModule;

@end

@implementation BBPreloader

-(instancetype)initWithWindow:(UIWindow *)window {
    self = [super init];
    if (self) {
        self.window = window;
        if ([[BBUserService sharedService] currentUser]) {
            [self.tabbarModule presentInWindow:window];
        } else {
            [self.registrationModule presentInWindow:window];
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

- (id<BBRegistrationModuleInput>) registrationModule {
    if (!_registrationModule) {
        _registrationModule = [BBRegistrationAssembly createModule];
    }
    return _registrationModule;
}

@end
