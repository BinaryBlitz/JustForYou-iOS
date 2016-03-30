//
//  BBNavigationModuleOutput.h
//  JustForYou
//
//  Created by Антон on 30.03.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBNavigationModuleOutput <NSObject>

- (void)userRegistrationFulfilled;

- (void)userRegistrationFulfilledWithView:(id)view;


@end
