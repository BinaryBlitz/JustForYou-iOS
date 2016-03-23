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

@interface BBPreloader ()

@property (weak, nonatomic) UIWindow *window;

@property (nonatomic) id<BBTabbarModuleInput> tabbarModule;

@end

@implementation BBPreloader

-(instancetype)initWithWindow:(UIWindow *)window {
    self = [super init];
    if (self) {
        self.window = window;
        [self.tabbarModule presentInWindow:window];
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


@end
