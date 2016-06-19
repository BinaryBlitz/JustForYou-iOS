//
//  BBAboutTableViewCell.h
//  JustForYou
//
//  Created by Антон on 19.06.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BBUnderlineButton.h"

@interface BBAboutTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *infoTextLabel;
@property (weak, nonatomic) IBOutlet BBUnderlineButton *goToWebsiteButton;

@end
