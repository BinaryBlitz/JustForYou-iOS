#import <UIKit/UIKit.h>

@protocol BBAddBasketViewDelegate;

@interface BBAddBasketViewPopover : UIView

@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UIView *popoverView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UIButton *minusButton;
@property (weak, nonatomic) IBOutlet UIButton *plusButton;
@property (weak, nonatomic) IBOutlet UIView *separatorView;
@property (weak, nonatomic) IBOutlet UIButton *okButton;
@property (weak, nonatomic) IBOutlet UILabel *totalCost;

@property (strong, nonatomic) id <BBAddBasketViewDelegate> delegate;

- (void)setPrimaryPrice:(NSInteger)primary secondary:(NSInteger)secondary threshold:(NSInteger)threshold;

@end

@protocol BBAddBasketViewDelegate <NSObject>

- (void)okButtonDidTapWithCountDays:(NSInteger)count;

@end
