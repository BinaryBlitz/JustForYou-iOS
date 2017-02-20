#import <Foundation/Foundation.h>

@interface BBExchange : NSObject

@property (assign, nonatomic) NSInteger exchangeId;
@property (assign, nonatomic) NSInteger programId;
@property (assign, nonatomic) NSInteger purchaseId;
@property (assign, nonatomic) BOOL paid;
@property (assign, nonatomic) NSInteger pengingBalanse;
@property (assign, nonatomic) NSInteger totalPrice;

- (instancetype)initWithJSON:(id)JSONObj;

@end
