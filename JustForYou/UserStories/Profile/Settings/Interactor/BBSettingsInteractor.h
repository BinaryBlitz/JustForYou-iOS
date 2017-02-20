#import "BBSettingsInteractorInput.h"

@protocol BBSettingsInteractorOutput;

@interface BBSettingsInteractor : NSObject <BBSettingsInteractorInput>

@property (weak, nonatomic) id <BBSettingsInteractorOutput> output;

@end
