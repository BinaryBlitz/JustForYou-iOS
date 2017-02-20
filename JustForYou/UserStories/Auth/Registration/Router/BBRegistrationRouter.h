#import "BBRegistrationRouterInput.h"

#import "BBRegistrationPresenter.h"

@interface BBRegistrationRouter : NSObject <BBRegistrationRouterInput>

@property (weak, nonatomic) BBRegistrationPresenter *presenter;

@end
