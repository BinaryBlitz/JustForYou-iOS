//
//  BBPreloader.m
//  JustForYou
//
//  Created by Антон on 19.03.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBPreloader.h"

#import "BBTestAssembly.h"
#import "BBTestModuleInput.h"


@interface BBPreloader ()

@property (weak, nonatomic) UIWindow *window;

@property (nonatomic) id<BBTestModuleInput> testModule;

@end

@implementation BBPreloader

-(instancetype)initWithWindow:(UIWindow *)window {
    self = [super init];
    if (self) {
        self.window = window;
        [self.testModule presentInWindow:window];
    }
    return self;
}

# pragma mark - Lazy Load

- (id<BBTestModuleInput>) testModule {
    if (!_testModule) {
        _testModule = [BBTestAssembly createModule];
    }
    return _testModule;
}@end
