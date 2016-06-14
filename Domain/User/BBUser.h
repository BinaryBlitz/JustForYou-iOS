//
//  BBUser.h
//  JustForYou
//
//  Created by Антон on 26.03.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BBUser : NSObject

@property (assign, nonatomic) NSInteger userId;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *surname;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *numberPhone;

@property (strong, nonatomic) NSArray *ordersProgramArray;
@property (strong, nonatomic) NSArray *addressArray;

-(instancetype)initWithJSON:(id)JSONObj;

@end
