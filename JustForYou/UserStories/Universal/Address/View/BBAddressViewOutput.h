//
//  BBAddressViewOutput.h
//  JustForYou
//
//  Created by tercteberc on 21/08/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBAddressViewOutput <NSObject>

- (void)didTriggerViewReadyEvent;
- (void)viewWillAppear;

- (void)streetCellDidSelect;

- (void)addAddressButtonDidTapWithAddress:(BBAddress *)address;

- (BOOL)apartmentFieldBeginEditingWithSymbol:(NSString *)symbol textInField:(NSString *)text;

@end