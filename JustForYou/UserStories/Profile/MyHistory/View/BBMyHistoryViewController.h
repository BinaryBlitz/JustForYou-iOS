#import <UIKit/UIKit.h>

#import "BBMyHistoryViewInput.h"

@protocol BBMyHistoryViewOutput;

@interface BBMyHistoryViewController : BBParentViewController <BBMyHistoryViewInput>

@property (weak, nonatomic) id <BBMyHistoryViewOutput> output;

@end
