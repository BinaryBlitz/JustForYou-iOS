#import <Foundation/Foundation.h>

@protocol BBCardProgramInteractorOutput <NSObject>

- (void)currentProgramInDataBase:(BBProgram *)program;

- (void)daysSaveInDataBase;

- (void)errorServer;
- (void)errorClient;

- (void)currentProgramsInBasket:(NSArray *)programs;

@end
