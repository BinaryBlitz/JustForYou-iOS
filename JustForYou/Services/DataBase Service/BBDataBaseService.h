#import <Foundation/Foundation.h>

#import <Realm/Realm.h>

#import "BBBlock.h"
#import "BBProgram.h"
#import "BBDay.h"
#import "BBOrder.h"
#import "BBPayCard.h"

typedef void (^CallBack)(void);

@interface BBDataBaseService : NSObject

+ (instancetype)sharedService;

#pragma mark - Blocks

- (void)addOrUpdateBlocksFromArray:(NSArray *)objects;
- (NSArray *)blocksInRealm;

#pragma mark - Programs

- (NSArray *)programsInRealmWithParentId:(NSInteger)parentId;
- (BBProgram *)programInRealmWithProgramId:(NSInteger)programId;
- (void)addOrUpdateProgramsFromArray:(NSArray *)objects parentId:(NSInteger)parentId;

#pragma mark - Days

- (NSArray *)daysInRealmWithParentId:(NSInteger)parentId;
- (void)addOrUpdateDaysFromArray:(NSArray *)objects parentId:(NSInteger)parentId;

#pragma mark - Orders

- (void)addOrUpdateOrdersFromArray:(NSArray *)objects callback:(CallBack)callback;
- (void)deleteOrderForOrderId:(NSInteger)orderId callback:(CallBack)callback;
- (NSArray *)ordersInRealm;

#pragma mark - PayCard

- (NSArray *)curentPayCards;
- (void)addOrUpdatePayCardsUserWithArray:(NSArray *)objects;
- (void)deletePayCard:(BBPayCard *)card;
- (void)deleteAllPayCardsUser;

@end
