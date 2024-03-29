#import <UIKit/UIKit.h>
#import <JTCalendar/JTCalendar.h>

#import "BBOrderViewControllerDelegate.h"

@protocol BBCalendarDeliveryCellDelegate;

@interface BBCalendarDeliveryTableViewCell : UITableViewCell <BBOrderViewControllerDelegate>

@property (weak, nonatomic) IBOutlet JTHorizontalCalendarView *calendarView;
@property (weak, nonatomic) IBOutlet UILabel *informationLabel;

@property (strong, nonatomic) id <BBCalendarDeliveryCellDelegate> delegate;

@property (assign, nonatomic) NSInteger countDayInOrder;
@property (strong, nonatomic) UIColor *purchaseColor;
@property (assign, nonatomic) BOOL isNewOrder;

- (void)setSelectionDays:(NSArray *)days;

- (void)successivelySelectedDay;
- (void)successivelySelectedDayWithoutWeekend;

- (NSArray *)selectedDays;

@end

@protocol BBCalendarDeliveryCellDelegate <NSObject>

- (void)updateNameMonthPreviousName:(NSString *)previousName currentName:(NSString *)currentName nextName:(NSString *)nextName;
- (void)showAlertViewWithMessage:(NSString *)message;

@optional
- (void)currentArraySelectionDays:(NSArray *)selectionDays;

@end
