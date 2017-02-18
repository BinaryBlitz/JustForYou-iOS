#import <UIKit/UIKit.h>

@protocol BBSearchTableControllerDelegate;

@interface BBSearchTableViewController : UITableViewController

@property (strong, nonatomic) NSArray *filterArray;
@property (strong, nonatomic) id <BBSearchTableControllerDelegate> delegate;

@end

@protocol BBSearchTableControllerDelegate <NSObject>

- (void)didSelectCellWithAddress:(BBAddress *)address;

@end
