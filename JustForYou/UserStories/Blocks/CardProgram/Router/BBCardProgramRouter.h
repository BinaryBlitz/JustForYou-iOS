#import "BBCardProgramRouterInput.h"

#import "BBCardProgramPresenter.h"

@interface BBCardProgramRouter : NSObject <BBCardProgramRouterInput>

@property (weak, nonatomic) BBCardProgramPresenter *presenter;

@end
