//
//  BBAddressService.h
//  JustForYou
//
//  Created by Антон on 26.05.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <LMAddress.h>
#import "BBAddress.h"

@interface BBAddressService : NSObject

+ (BBAddress *)addressFromAddress:(LMAddress *)addr;

@end
