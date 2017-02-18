#import <UIKit/UIKit.h>

@interface BBPartDayTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *partOfDayLabel;

- (void)setPartOfDayWithKey:(BBPartOfDay)key;

@end
