//
//  BBProgramsViewInput.h
//  JustForYou
//
//  Created by tercteberc on 07/04/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Realm/Realm.h>

@protocol BBProgramsViewInput <NSObject>

- (void)setupInitialState;

- (void)programsForTableView:(NSArray *)programs;

- (void)showBackgroundLoaderView;
- (void)hideBackgroundLoaderView;
- (void)presentAlertWithTitle:(NSString *)title message:(NSString *)message;

@end