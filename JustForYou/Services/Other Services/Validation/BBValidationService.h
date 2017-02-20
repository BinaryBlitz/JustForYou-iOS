#import <Foundation/Foundation.h>

@interface BBValidationService : NSObject

+ (NSString *)validateNumberPhoneWithNumber:(NSString *)simpleNumber deleteLastChar:(BOOL)deleteLastChar;

+ (NSString *)numberPhoneWithPrimaryString:(NSString *)primaryString;

+ (BOOL)validationEmailWithString:(NSString *)checkString;

@end
