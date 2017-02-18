#import <Foundation/Foundation.h>

#import <Realm/Realm.h>

@protocol BBProgramsInteractorOutput <NSObject>

- (void)currentProgramsInDataBase:(NSArray *)programs;

- (void)programsSaveInDataBase;

- (void)errorServer;
- (void)errorClient;

- (void)currentProgramsInBasket:(NSArray *)programs;

@end
