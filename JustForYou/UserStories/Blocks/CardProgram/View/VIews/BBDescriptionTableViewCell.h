#import <UIKit/UIKit.h>

#import "BBProgram.h"

@interface BBDescriptionTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *costLabel;
@property (weak, nonatomic) IBOutlet UILabel *bigCostLabel;

@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@property (strong, nonatomic) BBProgram *program;

- (void)reloadUIWithProgram:(BBProgram *)program;

@end
