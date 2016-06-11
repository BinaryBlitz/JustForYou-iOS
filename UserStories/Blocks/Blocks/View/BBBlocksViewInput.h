//
//  BBBlocksViewInput.h
//  JustForYou
//
//  Created by tercteberc on 28/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol BBBlocksViewInput <NSObject>

- (void)setupInitialState;

- (void)blocksForTableView:(NSArray *)blocks;

- (void)showLoaderView;
- (void)hideLoaderView;

- (void)presentAlertWithTitle:(NSString *)title message:(NSString *)message;

@end