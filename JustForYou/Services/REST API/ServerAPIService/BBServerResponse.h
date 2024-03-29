#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
  kSuccessfullyConnection,
  kErrorConnection
} BBServerServiceConnection;

typedef enum : NSUInteger {
  kResponce200 = 200,
  kResponce201 = 201,
} BBServerResponseCode;

typedef enum : NSUInteger {
  kServerErrorNone,
  kServerErrorSuccessfull,
  kServerErrorClient,
  kServerErrorServer
} BBErrorServer;

@interface BBServerResponse : NSObject

@property (assign, nonatomic, readonly) NSUInteger responseCode;
@property (assign, nonatomic, readonly) BBErrorServer serverError;
@property (assign, nonatomic, readonly) BBServerServiceConnection kConnectionServer;

- (instancetype)initWithResponse:(NSURLResponse *)responseServer keyConnection:(BBServerServiceConnection)key data:(NSData *)data;

@end
