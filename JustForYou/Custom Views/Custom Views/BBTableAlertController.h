#import <UIKit/UIKit.h>

#import "BBDataBaseService.h"

@protocol BBTableAlertControllerDelegate;

@interface BBTableAlertController : UIAlertController

@property (strong, nonatomic) id <BBTableAlertControllerDelegate> delegate;

@end

@protocol BBTableAlertControllerDelegate <NSObject>

- (void)cellDidSelectWithPayCard:(BBPayCard *)card;
- (void)payNewCardDidTap;
- (void)cancelButtonDidTap;

@end
