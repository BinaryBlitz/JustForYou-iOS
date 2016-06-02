//
//  BBValidationService.h
//  JustForYou
//
//  Created by Антон on 29.03.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBValidationService : NSObject

+ (NSString *)validateNumberPhoneWithNumber:(NSString *) simpleNumber deleteLastChar:(BOOL)deleteLastChar;

+ (NSString *)numberPhoneWithPrimaryString:(NSString *)primaryString;

+ (BOOL)validationEmailWithString:(NSString *)checkString;

@end
