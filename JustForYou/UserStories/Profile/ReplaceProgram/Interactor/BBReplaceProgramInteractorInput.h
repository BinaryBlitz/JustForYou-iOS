#import <Foundation/Foundation.h>

#import "BBExchange.h"
#import "BBPurchases.h"

@protocol BBReplaceProgramInteractorInput <NSObject>

- (void)listAllProgramsWithProgramId:(NSInteger)programId;

- (void)createReplaceWithPurchase:(BBPurchases *)purchase program:(BBProgram *)program;
- (void)payWithExchange:(BBExchange *)exchange card:(BBPayCard *)card;

@end
