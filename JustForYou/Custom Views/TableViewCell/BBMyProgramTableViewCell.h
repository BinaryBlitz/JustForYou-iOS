#import <UIKit/UIKit.h>

#import "BBPurchases.h"
#import "BBProgram.h"

typedef enum : NSUInteger {
  kProgramCellModeCornerRadius,
  kProgramCellModeDefault
} BBKeyProgramCellMode;

@interface BBMyProgramTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIView *indicatorView;
@property (weak, nonatomic) IBOutlet UILabel *subNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *countDayLabel;
@property (assign, nonatomic) BBKeyProgramCellMode keyMode;

@property (weak, nonatomic) BBPurchases *purchases;
@property (weak, nonatomic) BBProgram *program;

- (void)setDaysCount:(NSInteger)daysCount;

@end
