#import "BBTabbarInteractorInput.h"

@protocol BBTabbarInteractorOutput;

@interface BBTabbarInteractor : NSObject <BBTabbarInteractorInput>

@property (weak, nonatomic) id <BBTabbarInteractorOutput> output;

@end
