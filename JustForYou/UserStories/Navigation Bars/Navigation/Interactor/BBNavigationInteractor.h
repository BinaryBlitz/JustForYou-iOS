#import "BBNavigationInteractorInput.h"

@protocol BBNavigationInteractorOutput;

@interface BBNavigationInteractor : NSObject <BBNavigationInteractorInput>

@property (weak, nonatomic) id<BBNavigationInteractorOutput> output;

@end
