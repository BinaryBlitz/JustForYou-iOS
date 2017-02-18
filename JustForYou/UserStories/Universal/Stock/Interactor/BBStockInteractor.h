#import "BBStockInteractorInput.h"

@protocol BBStockInteractorOutput;

@interface BBStockInteractor : NSObject <BBStockInteractorInput>

@property (weak, nonatomic) id <BBStockInteractorOutput> output;

@end
