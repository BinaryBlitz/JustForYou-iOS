#import <UIKit/UIKit.h>

@interface BBAccessoryTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UIImageView *accessoryImageView;

@property (nonatomic) BBKeyModuleForUniversalModule keyModuleCell;

@property (nonatomic) BOOL setRadius;
@property (nonatomic) BBKeyCornerRadius kSideCornerRadius;

@end
