#import <Foundation/Foundation.h>

#import <Realm/Realm.h>

@protocol BBBlocksInteractorOutput <NSObject>

- (void)currentBlocksInDataBase:(NSArray *)blocks;

- (void)blocksSaveInDataBase;

- (void)errorServer;
- (void)errorClient;

- (void)currentProgramsInBasket:(NSArray *)programs;

@end
