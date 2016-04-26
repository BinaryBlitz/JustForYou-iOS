//
//  BBOrdersPresenter.m
//  JustForYou
//
//  Created by tercteberc on 28/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBOrdersPresenter.h"

#import "BBOrdersViewInput.h"
#import "BBOrdersInteractorInput.h"
#import "BBOrdersRouterInput.h"

#import "BBNavigationModuleInput.h"

@interface BBOrdersPresenter()

@property (strong, nonatomic) id<BBNavigationModuleInput> navigModule;

@end

@implementation BBOrdersPresenter

#pragma mark - Методы BBBlocksModuleInput

- (void)configureModule {
    
}

- (id)currentViewWithModule:(id)module {
    self.navigModule = module;
    return self.view;
}
#pragma mark - Методы BBOrdersViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
}

- (void)initCalendarManagerWithCalendarView:(JTHorizontalCalendarView *)calendarView {
    [self.interactor initCalendarManagerWithCalendarView:calendarView];
}

- (void)leftButtonDidTap {
    [self.interactor leftButtonDidTap];
}

- (void)rightButtonDidTap {
    [self.interactor rightButtonDidTap];
}

#pragma mark - Методы BBOrdersInteractorOutput

- (void)nameMonthPreviousName:(NSString *)previousName currentName:(NSString *)currentName nextName:(NSString *)nextName {
    [self.view updateNameMonthPreviousName:previousName currentName:currentName nextName:nextName];
}

@end