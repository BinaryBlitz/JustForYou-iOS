//
//  BBPayment.h
//  JustForYou
//
//  Created by Антон on 15.06.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBPayment : NSObject

@property (assign, nonatomic) NSInteger paymentId;
@property (strong, nonatomic) NSString *paymentURL;

-(instancetype)initWithJSON:(id)JSONObj;

@end
