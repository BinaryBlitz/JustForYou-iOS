#import "BBMyHistoryInteractorInput.h"

@protocol BBMyHistoryInteractorOutput;

@interface BBMyHistoryInteractor : NSObject <BBMyHistoryInteractorInput>

@property (weak, nonatomic) id<BBMyHistoryInteractorOutput> output;

@end
