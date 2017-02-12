//
//  BBMyHistoryRouter.h
//  JustForYou
//
//  Created by tercteberc on 25/06/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBMyHistoryRouterInput.h"

#import "BBMyHistoryPresenter.h"

@interface BBMyHistoryRouter : NSObject <BBMyHistoryRouterInput>

@property (weak, nonatomic) BBMyHistoryPresenter *presenter;

@end