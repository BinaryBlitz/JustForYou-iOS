#import <UIKit/UIKit.h>

#import "BBPayCard.h"

@interface BBMyCardTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameBankLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberCardLabel;

@property (strong, nonatomic) BBPayCard *card;

@end
