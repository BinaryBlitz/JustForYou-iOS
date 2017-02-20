#import <Foundation/Foundation.h>

#import <Realm/Realm.h>

#import "BBProgram.h"

@protocol BBProgramsInteractorInput <NSObject>

- (NSArray *)checkProgramsInDataBaseWith:(NSInteger)parentId;

- (void)programsInDataBaseWithParentId:(NSInteger)parentId;

- (void)listProgramsWithParentId:(NSInteger)parentId;

- (void)addInOrdersUserOrderWithProgramId:(NSInteger)programId countDay:(NSInteger)countDay;

- (void)checkBasket;

@end
