#import <UIKit/UIKit.h>

#import "BBDay.h"

@protocol BBNumberDayTableViewCell;

@interface BBNumderDayTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *numberDayLabel;
@property (weak, nonatomic) IBOutlet UILabel *caloriesLabel;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;

@property (nonatomic) NSInteger numberDay;

@property (strong, nonatomic) RLMResults *days;

- (void)setDaysAndUpdateUI:(RLMResults *)days;

@property (strong, nonatomic) id<BBNumberDayTableViewCell> delegate;

- (void)updateDayLabelWithNumber:(NSInteger)number;

@end

@protocol BBNumberDayTableViewCell <NSObject>

- (void)leftButtonDidTap;
- (void)rightButtonDidTap;

@end
