//
//  BBReplacementProduct.h
//  JustForYou
//
//  Created by Антон on 20.06.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBReplacementProduct : NSObject

@property (assign, nonatomic) NSInteger productId;
@property (strong, nonatomic) NSString *nameProduct;

- (instancetype)initWithJSON:(id)JSONObj;

@end
