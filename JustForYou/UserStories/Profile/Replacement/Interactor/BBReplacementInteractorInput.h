#import <Foundation/Foundation.h>

#import "BBReplacementCategory.h"

@protocol BBReplacementInteractorInput <NSObject>

- (void)currentReplacementUser;

- (void)deleteElementInArrayWithElement:(BBReplacementProduct *)element;

- (void)addInCurrentArrayReplacementNewElement:(BBReplacementProduct *)element;

- (void)listReplacementOnServer;

@end
