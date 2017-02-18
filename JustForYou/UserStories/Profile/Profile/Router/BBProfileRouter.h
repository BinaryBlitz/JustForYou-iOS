#import "BBProfileRouterInput.h"

#import "BBProfilePresenter.h"

@interface BBProfileRouter : NSObject <BBProfileRouterInput>

@property (weak, nonatomic) BBProfilePresenter *presenter;

@end
