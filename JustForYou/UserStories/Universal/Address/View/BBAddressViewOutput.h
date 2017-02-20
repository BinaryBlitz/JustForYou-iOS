#import <Foundation/Foundation.h>

@protocol BBAddressViewOutput <NSObject>

- (void)didTriggerViewReadyEvent;
- (void)viewWillAppear;

- (void)streetCellDidSelect;

- (void)addAddressButtonDidTapWithAddress:(BBAddress *)address;

- (BOOL)apartmentFieldBeginEditingWithSymbol:(NSString *)symbol textInField:(NSString *)text;

@end
