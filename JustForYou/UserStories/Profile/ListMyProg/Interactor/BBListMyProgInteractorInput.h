#import <Foundation/Foundation.h>

@protocol BBListMyProgInteractorInput <NSObject>

- (void)addInOrdersUserOrderWithProgramId:(NSInteger)programId countDay:(NSInteger)countDay;

- (void)listPurchasesUser;

@end
