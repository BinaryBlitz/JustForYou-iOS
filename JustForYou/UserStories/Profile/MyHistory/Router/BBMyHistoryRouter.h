#import "BBMyHistoryRouterInput.h"

#import "BBMyHistoryPresenter.h"

@interface BBMyHistoryRouter : NSObject <BBMyHistoryRouterInput>

@property (weak, nonatomic) BBMyHistoryPresenter *presenter;

@end
