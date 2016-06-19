//
//  BBUniversalInteractorInput.h
//  JustForYou
//
//  Created by tercteberc on 22/04/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBUniversalInteractorInput <NSObject>

- (void)currentAddressArray;

- (NSArray *)deleteAddress:(BBAddress *)address;

- (void)listShares;

@end
