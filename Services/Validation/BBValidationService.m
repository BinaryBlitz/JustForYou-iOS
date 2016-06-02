//
//  BBValidationService.m
//  JustForYou
//
//  Created by Антон on 29.03.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBValidationService.h"

@implementation BBValidationService

#pragma mark - Number Phone Methods

+ (NSString *)validateNumberPhoneWithNumber:(NSString *) simpleNumber deleteLastChar:(BOOL)deleteLastChar {
    if(simpleNumber.length == 0) {
        return @"";
    }
    
    NSError *error = NULL;
    // \s - символы пробелов(пропуска)
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[\\s-()]" options:NSRegularExpressionCaseInsensitive error:&error];
    
    simpleNumber = [regex stringByReplacingMatchesInString:simpleNumber options:0 range:NSMakeRange(0, [simpleNumber length]) withTemplate:@""];
    
    if(simpleNumber.length > 10) {
        simpleNumber = [simpleNumber substringToIndex:10];
    }
    
    if(deleteLastChar) {
        simpleNumber = [simpleNumber substringToIndex:[simpleNumber length] - 1];
    }
    
    if(simpleNumber.length < 7) { // \d - это цифры
        simpleNumber = [simpleNumber stringByReplacingOccurrencesOfString:@"(\\d{3})(\\d+)"
                                                               withString:@"($1) $2"
                                                                  options:NSRegularExpressionSearch
                                                                    range:NSMakeRange(0, [simpleNumber length])];
    } else if(simpleNumber.length < 9) {
        simpleNumber = [simpleNumber stringByReplacingOccurrencesOfString:@"(\\d{3})(\\d{3})(\\d+)"
                                                               withString:@"($1) $2-$3"
                                                                  options:NSRegularExpressionSearch
                                                                    range:NSMakeRange(0, [simpleNumber length])];
    } else {
        simpleNumber = [simpleNumber stringByReplacingOccurrencesOfString:@"(\\d{3})(\\d{3})(\\d{2})(\\d+)"
                                                               withString:@"($1) $2-$3-$4"
                                                                  options:NSRegularExpressionSearch
                                                                    range:NSMakeRange(0, [simpleNumber length])];
    }
    return simpleNumber;
}

+ (NSString *)numberPhoneWithPrimaryString:(NSString *)primaryString {
    primaryString = [primaryString stringByReplacingOccurrencesOfString:@"[^0-9]"
                                                           withString:@""
                                                              options:NSRegularExpressionSearch
                                                                range:NSMakeRange(0, [primaryString length])];
    
    NSMutableString *newPhone = [NSMutableString stringWithString:primaryString];
    [newPhone insertString:@"+7" atIndex:0];
    
    return newPhone;
}


#pragma mark - Email Methods

+ (BOOL)validationEmailWithString:(NSString *)checkString {
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

@end
