#import <UIKit/UIKit.h>

@interface BBTextTableViewCell : UITableViewCell

@property (nonatomic) BOOL setRadius;
@property (nonatomic) BBKeyCornerRadius kSideCornerRadius;
@property (nonatomic) BBKeyStyleContentCell kStyleContentCell;

@property (weak, nonatomic) IBOutlet UITextField *textField;

- (NSString *)getTextFromTextField;
- (void)setPlaceholderInTextField:(NSString *)placeholder;


@end
