//
//  BBStockViewInput.h
//  JustForYou
//
//  Created by tercteberc on 19/06/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBStockViewInput <NSObject>

- (void)setupInitialState;

- (void)stockForUI:(BBStock *)stock;

@end