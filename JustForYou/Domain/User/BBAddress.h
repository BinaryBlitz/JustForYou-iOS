#import <Foundation/Foundation.h>

@import MapKit;

@interface BBAddress : NSObject

@property (assign, nonatomic) NSInteger addressId;
@property (assign, nonatomic) CLLocationCoordinate2D coordinate;
@property (strong, nonatomic) NSString *country;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *street;
@property (strong, nonatomic) NSString *house;
@property (nonatomic) NSInteger apartment;
@property (nonatomic) NSInteger floor;
@property (nonatomic) NSInteger entrance;

- (instancetype)initWithJSON:(id)JSONObj;

- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate country:(NSString *)country city:(NSString *)city street:(NSString *)street house:(NSString *)house;

- (NSString *)formatedDescription;

@end
