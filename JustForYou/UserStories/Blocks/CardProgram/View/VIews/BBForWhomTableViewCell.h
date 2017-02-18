#import <UIKit/UIKit.h>

@interface BBForWhomTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptLabel;
@property (weak, nonatomic) IBOutlet UILabel *costLabel;
@property (weak, nonatomic) IBOutlet UILabel *bigCostLabel;

@property (strong, nonatomic) NSString *first;
@property (strong, nonatomic) NSString *second;
@property (strong, nonatomic) NSString *third;

@property (strong, nonatomic) BBProgram *program;

- (void)setDescriptions:(NSString *)first :(NSString *)second :(NSString *)third;
- (void)reloadUIWithProgram:(BBProgram *)program;

@end
