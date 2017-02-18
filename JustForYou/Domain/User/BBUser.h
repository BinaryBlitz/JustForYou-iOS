#import <Foundation/Foundation.h>

@interface BBUser : NSObject

@property (assign, nonatomic) NSInteger userId;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *surname;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *numberPhone;
@property (assign, nonatomic) NSInteger balance;
@property (assign, nonatomic) NSInteger countPurchases;
@property (assign, nonatomic) BOOL enableBonuses;
@property (strong, nonatomic) NSArray *ordersProgramArray;
@property (strong, nonatomic) NSArray *addressArray;

- (instancetype)initWithJSON:(id)JSONObj;

@end
