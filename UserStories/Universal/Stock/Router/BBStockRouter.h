//
//  BBStockRouter.h
//  JustForYou
//
//  Created by tercteberc on 19/06/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBStockRouterInput.h"

#import "BBStockPresenter.h"

@interface BBStockRouter : NSObject <BBStockRouterInput>

@property (weak, nonatomic) BBStockPresenter *presenter;

@end