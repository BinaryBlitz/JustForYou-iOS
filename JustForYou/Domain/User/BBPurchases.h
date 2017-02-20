#import <Foundation/Foundation.h>

#import "BBElementBlock.h"

@interface BBPurchases : NSObject

@property (assign, nonatomic) NSInteger purchasesId;
@property (assign, nonatomic) NSInteger numberDays;
@property (assign, nonatomic) NSInteger deliveriesCount;
@property (assign, nonatomic) NSInteger countDays;
@property (assign, nonatomic) NSInteger programId;
@property (assign, nonatomic) NSInteger primaryPrice;
@property (assign, nonatomic) NSInteger secondaryPrice;
@property (assign, nonatomic) NSInteger threshold;
@property (strong, nonatomic) NSString *nameProgram;
@property (strong, nonatomic) BBElementBlock *elementBlock;

- (instancetype)initWithJSON:(id)JSONObj;

@end
