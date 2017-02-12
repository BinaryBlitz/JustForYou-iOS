//
//  BBBlocksInteractorOutput.h
//  JustForYou
//
//  Created by tercteberc on 28/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Realm/Realm.h>

@protocol BBBlocksInteractorOutput <NSObject>

- (void)currentBlocksInDataBase:(NSArray *)blocks;

- (void)blocksSaveInDataBase;

- (void)errorServer;
- (void)errorClient;

- (void)currentProgramsInBasket:(NSArray *)programs;

@end