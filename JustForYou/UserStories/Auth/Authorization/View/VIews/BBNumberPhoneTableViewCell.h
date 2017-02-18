#import <UIKit/UIKit.h>

@protocol BBNumberCellDelegate;

@interface BBNumberPhoneTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *numberTextField;

@property (strong, nonatomic) id<BBNumberCellDelegate> delegate;

@property (nonatomic) BOOL validationOk;

@end

@protocol BBNumberCellDelegate <NSObject>

- (void)numberPhoneValidate;

@end
