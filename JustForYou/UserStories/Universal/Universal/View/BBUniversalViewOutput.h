#import <Foundation/Foundation.h>

@protocol BBUniversalViewOutput <NSObject>

- (void)didTriggerViewReadyEvent;

- (void)viewWillAppear;

- (void)cellDidSelectWithAdress:(BBAddress *)adress;

- (void)cellDidSelectWithStock:(BBStock *)stock;

- (void)deletedCellWithAddress:(BBAddress *)address;

- (void)deletedCellWithPayCard:(BBPayCard *)card;

- (void)addBarButtonDidTap;

@end
