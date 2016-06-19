//
//  BBCardProgramInteractorOutput.h
//  JustForYou
//
//  Created by tercteberc on 07/04/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBCardProgramInteractorOutput <NSObject>

- (void)currentProgramInDataBase:(BBProgram *)program;

- (void)daysSaveInDataBase;

- (void)errorServer;
- (void)errorClient;

- (void)currentProgramsInBasket:(NSArray *)programs;

@end