//
//  NSData+BBParserAPI.h
//  JustForYou
//
//  Created by Антон on 21.05.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BBUser.h"

@interface NSData (BBParserAPI)

- (NSString *)parseAuthorizateToken;

- (id)parseSearchAddress;

- (BBUser *)parseRegisterResponseWithData;

@end
