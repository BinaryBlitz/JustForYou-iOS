//
//  BBPurchases.h
//  JustForYou
//
//  Created by Антон on 21.06.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BBElementBlock.h"

@interface BBPurchases : NSObject

@property (assign, nonatomic) NSInteger purchasesId;
@property (assign, nonatomic) NSInteger numberDays;
@property (assign, nonatomic) NSInteger programId;
@property (strong, nonatomic) NSString *nameProgram;
@property (strong, nonatomic) BBElementBlock *elementBlock;

- (instancetype)initWithJSON:(id)JSONObj;

@end
