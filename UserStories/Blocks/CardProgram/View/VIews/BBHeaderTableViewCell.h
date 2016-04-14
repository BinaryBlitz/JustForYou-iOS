//
//  BBHeaderTableViewCell.h
//  JustForYou
//
//  Created by Антон on 09.04.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BBSegmentedControl.h"

@interface BBHeaderTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet BBSegmentedControl *segmentedControl;

@end
