#import <Foundation/Foundation.h>

@interface BBOrderProgram : NSObject

@property (assign, nonatomic) NSInteger programId;

@property (assign, nonatomic) BOOL isPurchased;
@property (strong, nonatomic) NSArray *days;
@property (assign, nonatomic) NSString *commentOrder;
@property (assign, nonatomic) NSString *nameProgram;
@property (assign, nonatomic) NSString *nameBlock;
@property (assign, nonatomic) NSInteger hour;
@property (assign, nonatomic) NSInteger minute;

@property (strong, nonatomic) BBAddress *address;


@end
