//
//  BBProgramHistory.h
//  JustForYou
//
//  Created by Антон on 25.06.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BBElementBlock.h"

@interface BBProgramHistory : NSObject

@property (assign, nonatomic) NSInteger historyId;
@property (assign, nonatomic) NSInteger totalPrice;
@property (strong, nonatomic) NSDate *dateCreate;
@property (strong, nonatomic) NSString *nameProgram;
@property (strong, nonatomic) BBElementBlock *elementBlock;

- (instancetype)initWithJSON:(id)JSONObj program:(id)program;

@end
