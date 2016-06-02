//
//  BBAddressTableViewCell.h
//  JustForYou
//
//  Created by Антон on 02.06.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BBAddress.h"

@interface BBAddressTableViewCell : UITableViewCell

@property (strong, nonatomic) BBAddress *address;

- (void)updateTextLabelWithAddress;

@end
