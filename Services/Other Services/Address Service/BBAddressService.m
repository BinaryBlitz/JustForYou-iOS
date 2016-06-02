//
//  BBAddressService.m
//  JustForYou
//
//  Created by Антон on 26.05.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

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

+ (instancetype) sharedService {
    static BBAddressService* service = nil;
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
    NSString *route = [self component:@"route" inArray:addr.lines ofType:@"short_name"];
    NSString *streetName = nil;
    
    if (route && addr.thoroughfare) {
        streetName = [NSString stringWithFormat:@"%@, %@", route, addr.thoroughfare];
    } else if (route) {
        streetName = [NSString stringWithFormat:@"%@", route];
    } else {
        return nil;
    }
    
    BBAddress *address = [[BBAddress alloc] initWithCoordinate:addr.coordinate country:addr.country city:addr.locality address:streetName];
    
    return address;
}


- (NSString *)component:(NSString *)component inArray:(NSArray *)array ofType:(NSString *)type {
    
    NSInteger index = [array indexOfObjectPassingTest:^(id obj, NSUInteger idx, BOOL *stop) {
        return [(NSString *)([[obj objectForKey:@"types"] firstObject]) isEqualToString:component];
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
    
    NSString* webStringURL = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
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
                NSString *addr = [address objectForKey:@"formatted_address"];
                NSDictionary *location = [[address objectForKey:@"geometry"] objectForKey:@"location"];
                
                double lat = [location[@"lat"] doubleValue];
                double lng = [location[@"lng"] doubleValue];
                CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(lat, lng);
                BBAddress *adr = [[BBAddress alloc] initWithCoordinate:coordinate country:@"Россия" city:@"" address:addr];
                [searchAdr addObject:adr];
            }
        }
    }

    return searchAdr;
}


#pragma mark - Lazy Load

- (BBServerTransport *) transport {
    if (!_transport) {
        _transport = [[BBServerTransport alloc] init];
    }
    return _transport;
}

@end
