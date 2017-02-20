#import <UIKit/UIKit.h>

#import "JTHorizontalCalendarView.h"

#import "BBDottedBorderButton.h"

#import "BBOrderViewControllerDelegate.h"

@protocol BBCalendarTableViewCellDelegate;

@interface BBCalendarTableViewCell : UITableViewCell <BBOrderViewControllerDelegate>

@property (weak, nonatomic) IBOutlet JTHorizontalCalendarView *calendarView;
@property (weak, nonatomic) IBOutlet BBDottedBorderButton *addNewOrderButton;

@property (strong, nonatomic) id <BBCalendarTableViewCellDelegate> delegate;

@property (strong, nonatomic) NSArray *ordersForCalendar;

@end

@protocol BBCalendarTableViewCellDelegate <NSObject>

- (void)updateNameMonthPreviousName:(NSString *)previousName currentName:(NSString *)currentName nextName:(NSString *)nextName;
- (void)dayViewDidTapWithOrders:(NSArray *)orders;
- (void)addNewOrderButtonDidTap;

@end
