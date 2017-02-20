#import "BBMyProgramsRouterInput.h"

#import "BBMyProgramsPresenter.h"

@interface BBMyProgramsRouter : NSObject <BBMyProgramsRouterInput>

@property (weak, nonatomic) BBMyProgramsPresenter *presenter;

@end
