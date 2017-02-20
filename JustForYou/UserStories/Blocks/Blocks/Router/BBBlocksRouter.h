#import "BBBlocksRouterInput.h"

#import "BBBlocksPresenter.h"

@interface BBBlocksRouter : NSObject <BBBlocksRouterInput>

@property (weak, nonatomic) BBBlocksPresenter *presenter;

@end
