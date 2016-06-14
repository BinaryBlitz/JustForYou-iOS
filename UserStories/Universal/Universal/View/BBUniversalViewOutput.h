//
//  BBUniversalViewOutput.h
//  JustForYou
//
//  Created by tercteberc on 22/04/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBUniversalViewOutput <NSObject>

- (void)didTriggerViewReadyEvent;

- (void)viewWillAppear;

- (void)cellDidSelectWithAdress:(NSString *)adress;

- (void)deletedCellWithAddress:(BBAddress *)address;

- (void)addBarButtonDidTap;

@end
