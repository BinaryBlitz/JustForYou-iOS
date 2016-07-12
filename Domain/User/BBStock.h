//
//  BBStock.h
//  JustForYou
//
//  Created by Антон on 19.06.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBStock : NSObject

@property (assign, nonatomic) NSInteger stockId;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *descript;
@property (strong, nonatomic) NSDate *date;

- (instancetype)initWithJSON:(id)JSONObj;

@end
