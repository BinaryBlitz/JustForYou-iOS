#import <UIKit/UIKit.h>

@protocol BBCommentTableViewCellDelegate;

@interface BBCommentTableViewCell : UITableViewCell <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *placeholderLabel;
@property (weak, nonatomic) IBOutlet UITextView *textView;

- (void)setComment:(NSString*)comment;

@property (strong, nonatomic) id <BBCommentTableViewCellDelegate> delegate;

@end

@protocol BBCommentTableViewCellDelegate <NSObject>

- (void)commentDidChange:(NSString*)comment;

@end
