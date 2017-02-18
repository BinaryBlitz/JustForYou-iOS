#import "BBMyHistoryViewOutput.h"
#import "BBMyHistoryInteractorOutput.h"
#import "BBMyHistoryModuleInput.h"

@protocol BBMyHistoryViewInput;
@protocol BBMyHistoryInteractorInput;
@protocol BBMyHistoryRouterInput;

@interface BBMyHistoryPresenter : NSObject <BBMyHistoryModuleInput, BBMyHistoryViewOutput, BBMyHistoryInteractorOutput>

@property (strong, nonatomic) id <BBMyHistoryViewInput> view;
@property (strong, nonatomic) id <BBMyHistoryInteractorInput> interactor;
@property (strong, nonatomic) id <BBMyHistoryRouterInput> router;

@end
