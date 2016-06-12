//
//  BBHeaderTableViewCell.h
//  JustForYou
//
//  Created by Антон on 09.04.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BBSegmentedControl.h"

@protocol BBHeaderTableViewCellDelegate;

@interface BBHeaderTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageProgram;
@property (weak, nonatomic) IBOutlet BBSegmentedControl *segmentedControl;

@property (strong, nonatomic) id<BBHeaderTableViewCellDelegate> delegate;

@end

@protocol BBHeaderTableViewCellDelegate <NSObject>
@optional

- (void)segmentedControlValueChange:(BBCardProgramSegmentedIndex)segmentedIndex;

@end
