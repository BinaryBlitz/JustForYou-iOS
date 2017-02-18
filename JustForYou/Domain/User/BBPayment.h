#import <Foundation/Foundation.h>

@interface BBPayment : NSObject

@property (assign, nonatomic) NSInteger paymentId;
@property (strong, nonatomic) NSString *paymentURL;

- (instancetype)initWithJSON:(id)JSONObj;

@end
