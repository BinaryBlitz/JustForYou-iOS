#import "BBProgramsRouterInput.h"

#import "BBProgramsPresenter.h"

@interface BBProgramsRouter : NSObject <BBProgramsRouterInput>

@property (weak, nonatomic) BBProgramsPresenter *presenter;

@end
