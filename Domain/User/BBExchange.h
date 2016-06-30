//
//  BBExchange.h
//  JustForYou
//
//  Created by Антон on 30.06.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBExchange : NSObject

@property (assign, nonatomic) NSInteger exchangeId;
@property (assign, nonatomic) NSInteger programId;
@property (assign, nonatomic) NSInteger purchaseId;
@property (assign, nonatomic) BOOL paid;
@property (assign, nonatomic) NSInteger pengingBalanse;

- (instancetype)initWithJSON:(id)JSONObj;

@end
