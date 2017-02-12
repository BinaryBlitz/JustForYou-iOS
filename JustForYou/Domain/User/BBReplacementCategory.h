//
//  BBReplacementCategory.h
//  JustForYou
//
//  Created by Антон on 20.06.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BBReplacementProduct.h"

@interface BBReplacementCategory : NSObject

@property (assign, nonatomic) NSInteger categoryId;
@property (strong, nonatomic) NSString *nameCategory;
@property (strong, nonatomic) NSArray *products;

- (instancetype)initWithJSON:(id)JSONObj;

@end
