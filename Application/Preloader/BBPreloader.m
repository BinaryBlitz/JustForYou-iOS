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

#import "BBUserService.h"

@interface BBPreloader () <BBNavigationModuleOutput>

@property (weak, nonatomic) UIWindow *window;

@property (strong, nonatomic) id<BBTabbarModuleInput> tabbarModule;
@property (strong, nonatomic) id<BBNavigationModuleInput> navigationModule;

@end

@implementation BBPreloader

-(instancetype)initWithWindow:(UIWindow *)window {
    self = [super init];
    if (self) {
        self.window = window;
        if ([[BBUserService sharedService] currentUser]) {
            [self.tabbarModule presentInWindow:window];
        } else {
            [self.navigationModule presentInWindow:window];
        }
    }
    return self;
}

#pragma mark - методы BBNavigationModuleOutput

- (void)userRegistrationFulfilled {
    UIViewController *vc = [self.tabbarModule currentView];
    __weak typeof(self)weakSelf = self;
    
    HQDispatchToMainQueue(^{
        [UIView transitionWithView:self.window
                          duration:0.5f
                           options:UIViewAnimationOptionShowHideTransitionViews
                        animations:^{
                            weakSelf.window.rootViewController = vc;
                        }
                        completion:nil];
    });

}

- (void)userRegistrationFulfilledWithView:(id)view {
    
    UIViewController *vc = [self.tabbarModule currentView];
    __weak typeof(self)weakSelf = self;
    
    HQDispatchToMainQueue(^{
        [UIView animateWithDuration:0.5f
                              delay:0
                            options:UIViewAnimationOptionTransitionCrossDissolve
                         animations:^{
                        weakSelf.window.rootViewController = vc;
        } completion:nil];
    });
}

/*
 
UIViewAnimationOptionLayoutSubviews            = 1 <<  0,
UIViewAnimationOptionAllowUserInteraction      = 1 <<  1, // turn on user interaction while animating
UIViewAnimationOptionBeginFromCurrentState     = 1 <<  2, // start all views from current value, not initial value
UIViewAnimationOptionRepeat                    = 1 <<  3, // repeat animation indefinitely
UIViewAnimationOptionAutoreverse               = 1 <<  4, // if repeat, run animation back and forth
UIViewAnimationOptionOverrideInheritedDuration = 1 <<  5, // ignore nested duration
UIViewAnimationOptionOverrideInheritedCurve    = 1 <<  6, // ignore nested curve
UIViewAnimationOptionAllowAnimatedContent      = 1 <<  7, // animate contents (applies to transitions only)
UIViewAnimationOptionShowHideTransitionViews   = 1 <<  8, // flip to/from hidden state instead of adding/removing
UIViewAnimationOptionOverrideInheritedOptions  = 1 <<  9, // do not inherit any options or animation type

UIViewAnimationOptionCurveEaseInOut            = 0 << 16, // default
UIViewAnimationOptionCurveEaseIn               = 1 << 16,
UIViewAnimationOptionCurveEaseOut              = 2 << 16,
UIViewAnimationOptionCurveLinear               = 3 << 16,

UIViewAnimationOptionTransitionNone            = 0 << 20, // default
UIViewAnimationOptionTransitionFlipFromLeft    = 1 << 20,
UIViewAnimationOptionTransitionFlipFromRight   = 2 << 20,
UIViewAnimationOptionTransitionCurlUp          = 3 << 20,
UIViewAnimationOptionTransitionCurlDown        = 4 << 20,
UIViewAnimationOptionTransitionCrossDissolve   = 5 << 20,
UIViewAnimationOptionTransitionFlipFromTop     = 6 << 20,
UIViewAnimationOptionTransitionFlipFromBottom  = 7 << 20,
 
*/
# pragma mark - Lazy Load

- (id<BBTabbarModuleInput>) tabbarModule {
    if (!_tabbarModule) {
        _tabbarModule = [BBTabbarAssembly createModule];
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
