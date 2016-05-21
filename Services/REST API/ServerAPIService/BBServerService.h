//
//  BBServerService.h
//  JustForYou
//
//  Created by Антон on 21.05.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^AuthCompletion)(/*User* user,*/ NSError* error);
typedef void (^ReceiveData)(NSData* data);

@interface BBServerService : NSObject

@end
