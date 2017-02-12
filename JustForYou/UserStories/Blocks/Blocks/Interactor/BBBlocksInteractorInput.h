//
//  BBBlocksInteractorInput.h
//  JustForYou
//
//  Created by tercteberc on 28/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Realm/Realm.h>

#import "BBBlock.h"

@protocol BBBlocksInteractorInput <NSObject>

- (BOOL)checkObjectsInDataBase;

- (void)blocksInDataBase;

- (void)listBlocksWithKey:(BBKeyStateData)key;

- (void)checkBasket;

@end