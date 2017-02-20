#import <UIKit/UIKit.h>

#import "BBMenu.h"

@interface BBMenuTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *menuLabel;
@property (weak, nonatomic) IBOutlet UILabel *caloriesLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

- (void)setMenuWithMenu:(BBMenu *)menu;

@end
