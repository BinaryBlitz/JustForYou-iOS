#import <UIKit/UIKit.h>

#import "BBStock.h"

@interface BBStockTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *accessoryImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameStockLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionStockLabel;

@property (strong, nonatomic) BBStock *stock;

- (void)setStockForUI:(BBStock *)stock;

@end
