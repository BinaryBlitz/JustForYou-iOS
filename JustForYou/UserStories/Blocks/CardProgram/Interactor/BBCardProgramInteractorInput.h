#import <Foundation/Foundation.h>

@protocol BBCardProgramInteractorInput <NSObject>

- (NSArray *)checkDaysInDataBaseWith:(NSInteger)parentId;

- (void)programInDataBaseWithParentId:(NSInteger)parentId;

- (void)listDaysWithParentId:(NSInteger)parentId;


- (void)addInOrdersUserOrderWithProgramId:(NSInteger)programId countDay:(NSInteger)countDay;

- (void)checkBasket;

@end
