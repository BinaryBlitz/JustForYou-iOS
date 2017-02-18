#import <UIKit/UIKit.h>

@protocol BBTimeCellDelegate;

@interface BBTimeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *minusButton;
@property (weak, nonatomic) IBOutlet UIButton *plusButton;

@property (strong, nonatomic) id <BBTimeCellDelegate> delegate;

- (void)startHourAndMinute;

@end

@protocol BBTimeCellDelegate <NSObject>

- (void)presentAlertForMessage:(NSString *)message;
- (void)startHour:(NSInteger)startHour startMinute:(NSInteger)startMinute;

@end
