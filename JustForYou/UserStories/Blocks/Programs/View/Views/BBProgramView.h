#import <UIKit/UIKit.h>

#import "BBProgram.h"

@protocol BBProgramViewDelegate;

@interface BBProgramView : UIView

@property (weak, nonatomic) IBOutlet UILabel *nameProgram;
@property (weak, nonatomic) IBOutlet UILabel *costProgram;
@property (weak, nonatomic) IBOutlet UILabel *bigCostProgram;
@property (weak, nonatomic) IBOutlet UILabel *shortDescription;

@property (weak, nonatomic) IBOutlet BBUnderlineButton *moreButton;

@property (strong, nonatomic) id<BBProgramViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (strong, nonatomic) BBProgram *program;

- (void)setProgramInUI:(BBProgram *)program;

@end


@protocol BBProgramViewDelegate <NSObject>
- (void)moreButtonDidTap;

@end
