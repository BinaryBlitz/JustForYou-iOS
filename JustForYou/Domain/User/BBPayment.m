#import "BBPayment.h"

@implementation BBPayment

-(instancetype)initWithJSON:(id)JSONObj {
    self = [super init];
    if (self) {
        self.paymentId = [[JSONObj valueForKey:@"id"] integerValue];
        self.paymentURL = [JSONObj valueForKey:@"payment_url"];
    }
    return self;
}

@end
