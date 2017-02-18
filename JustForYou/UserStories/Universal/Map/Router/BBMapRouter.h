#import "BBMapRouterInput.h"

#import "BBMapPresenter.h"

@interface BBMapRouter : NSObject <BBMapRouterInput>

@property (weak, nonatomic) BBMapPresenter *presenter;

@end
