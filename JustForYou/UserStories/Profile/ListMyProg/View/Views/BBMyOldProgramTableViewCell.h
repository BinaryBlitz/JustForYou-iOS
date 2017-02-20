#import <UIKit/UIKit.h>

@protocol BBMyOldProgramCellDelegate;

@interface BBMyOldProgramTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIView *indicatorView;
@property (weak, nonatomic) IBOutlet UILabel *subnameLabel;
@property (weak, nonatomic) IBOutlet UILabel *coundDayLabel;
@property (weak, nonatomic) IBOutlet UIButton *replaceButton;
@property (weak, nonatomic) IBOutlet UIButton *extendButton;

@property (strong, nonatomic) id <BBMyOldProgramCellDelegate> delegate;

@property (strong, nonatomic) BBPurchases *purchase;

@end

@protocol BBMyOldProgramCellDelegate <NSObject>

- (void)extendButtonDidTapWithPurchase:(BBPurchases *)purchase;
- (void)replaceButtonDidTapWithPurchase:(BBPurchases *)purchase;

@end
