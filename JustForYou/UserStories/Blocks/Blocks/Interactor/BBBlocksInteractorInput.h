#import <Foundation/Foundation.h>

#import <Realm/Realm.h>

#import "BBBlock.h"

@protocol BBBlocksInteractorInput <NSObject>

- (BOOL)checkObjectsInDataBase;

- (void)blocksInDataBase;

- (void)listBlocksWithKey:(BBKeyStateData)key;

- (void)checkBasket;

@end
