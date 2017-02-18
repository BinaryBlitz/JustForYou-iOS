#import <UIKit/UIKit.h>

#import "BBAddress.h"

@interface BBAddressTableViewCell : UITableViewCell

@property (strong, nonatomic) BBAddress *address;

- (void)updateTextLabelWithAddress;

@end
