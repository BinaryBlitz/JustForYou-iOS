#import <UIKit/UIKit.h>

@protocol BBCalendarMenuViewDelegate;

@interface BBCalendarMenuView : UIView

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (strong, nonatomic) id<BBCalendarMenuViewDelegate> delegate;

@end

@protocol BBCalendarMenuViewDelegate
@optional

- (void)leftButtonDidTap;
- (void)rightButtonDidTap;

@end
