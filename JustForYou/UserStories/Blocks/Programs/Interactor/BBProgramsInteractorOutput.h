//
//  BBProgramsInteractorOutput.h
//  JustForYou
//
//  Created by tercteberc on 07/04/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Realm/Realm.h>

@protocol BBProgramsInteractorOutput <NSObject>

- (void)currentProgramsInDataBase:(NSArray *)programs;

- (void)programsSaveInDataBase;

- (void)errorServer;
- (void)errorClient;

- (void)currentProgramsInBasket:(NSArray *)programs;

@end