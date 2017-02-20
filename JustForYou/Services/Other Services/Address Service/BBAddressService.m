#import "BBAddressService.h"

#import "BBServerTransport.h"

#import "NSData+BBParserAPI.h"

@interface BBAddressService ()

@property (strong, nonatomic) BBServerTransport *transport;

@end

static NSString *kGoogleMapsApi = @"AIzaSyD1Duwq-ZOGPw4YFo2CKzuQATDcizqbDNc";
static NSString *kGeocodingMaps = @"AIzaSyAWZ0qc1ZSburzcALU5mIde71hougesmqM";

static NSString *kStatusOK = @"OK";

@implementation BBAddressService

+ (instancetype)sharedService {
  static BBAddressService *service = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    service = [[BBAddressService alloc] init];
  });
  return service;
}

- (NSString *)currentApiKeyMap {
  return kGoogleMapsApi;
}

- (BBAddress *)addressFromAddress:(LMAddress *)addr {
  NSString *route = [addr valueForKey:@"route"];//[self component:@"route" inArray:addr.lines ofType:@"short_name"];
  BBAddress *address = nil;
  if (route && addr.streetNumber) {
    address = [[BBAddress alloc] initWithCoordinate:addr.coordinate country:addr.country city:addr.locality street:route house:addr.streetNumber];
  } else if (route) {
    address = [[BBAddress alloc] initWithCoordinate:addr.coordinate country:addr.country city:addr.locality street:route house:nil];
  }

  return address;
}

- (NSString *)component:(NSString *)component inArray:(NSArray *)array ofType:(NSString *)type {

  NSInteger index = [array indexOfObjectPassingTest:^(id obj, NSUInteger idx, BOOL *stop) {
    return [(NSString *) ([[obj objectForKey:@"types"] firstObject]) isEqualToString:component];
  }];

  if (index == NSNotFound) {
    return nil;
  }

  if (index >= array.count) {
    return nil;
  }

  return [[array objectAtIndex:index] valueForKey:type];
}

#pragma mark - Serach GeoLocation

- (void)searchGeopositionForAddress:(NSString *)address completion:(CompletionArray)completion {
  NSMutableString *urlString = [NSMutableString stringWithFormat:@"https://maps.googleapis.com/maps/api/geocode/json?address=Moskow %@&key=%@", address, kGeocodingMaps];

  [urlString setString:[urlString stringByReplacingOccurrencesOfString:@" " withString:@"+"]];

  NSString *webStringURL = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

  NSURL *url = [NSURL URLWithString:webStringURL];
  [self.transport searchGeolocationWithURL:url completion:^(NSData *data, NSURLResponse *response, NSError *error) {
    NSArray *adr = nil;
    if (!error && data) {
      adr = [self arrayAddressFromSearchAddress:[data parseSearchAddress]];
    }
    completion(adr);
  }];
}

- (NSArray *)arrayAddressFromSearchAddress:(id)geoposition {
  NSMutableArray *searchAdr = nil;
  if ([[geoposition objectForKey:@"status"] isEqualToString:kStatusOK]) {
    NSArray *addressArray = [geoposition objectForKey:@"results"];

    if ([addressArray count] > 0) {
      searchAdr = [NSMutableArray array];
      for (NSDictionary *address in addressArray) {
        NSDictionary *shortAdr = [[address objectForKey:@"address_components"] firstObject];
        NSString *addr = [shortAdr objectForKey:@"short_name"];
        NSDictionary *location = [[address objectForKey:@"geometry"] objectForKey:@"location"];

        double lat = [location[@"lat"] doubleValue];
        double lng = [location[@"lng"] doubleValue];
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(lat, lng);
        BBAddress *adr = [[BBAddress alloc] initWithCoordinate:coordinate country:@"Россия" city:@"Москва" street:addr house:nil];
        [searchAdr addObject:adr];
      }
    }
  }

  return searchAdr;
}

#pragma mark - Lazy Load

- (BBServerTransport *)transport {
  if (!_transport) {
    _transport = [[BBServerTransport alloc] init];
  }
  return _transport;
}

@end
