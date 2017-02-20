#import "BBServerResponse.h"

@interface BBServerResponse ()

@property (assign, nonatomic) NSUInteger responseCode;
@property (assign, nonatomic) BBErrorServer serverError;
@property (assign, nonatomic) BBServerServiceConnection kConnectionServer;

@end

@implementation BBServerResponse

- (instancetype)initWithResponse:(NSURLResponse *)responseServer keyConnection:(BBServerServiceConnection)key data:(NSData *)data {
  self = [super init];
  if (self) {
    self.serverError = [self parseServerErrorWithResponse:responseServer data:data];
    self.kConnectionServer = key;
  }
  return self;
}

- (BBErrorServer)parseServerErrorWithResponse:(NSURLResponse *)response data:(NSData *)data {
  NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
  self.responseCode = [httpResponse statusCode];
  if (self.responseCode < 200) {
    return kServerErrorNone;
  } else if (self.responseCode >= 200 && self.responseCode < 300) {
    return kServerErrorSuccessfull;
  } else if (self.responseCode >= 400 && self.responseCode < 500) {
    if (self.responseCode == 401) {
      if ([self checkUserOnLogoutWithData:data]) {
        return kServerErrorClient;
      }
      return kServerErrorNone;
    }
    return kServerErrorClient;
  } else if (self.responseCode >= 500 && self.responseCode < 600) {
    return kServerErrorServer;
  }
  return kServerErrorNone;
}

- (BOOL)checkUserOnLogoutWithData:(NSData *)data {
  if (data) {
    id JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSString *invalid = [JSON valueForKey:@"message"];
    if (invalid && [invalid isEqualToString:@"Invalid API Token"]) {
      [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLogOutUser object:nil];
      return NO;
    }
  }
  return YES;
}

@end
