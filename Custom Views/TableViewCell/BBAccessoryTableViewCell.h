//
//  BBAccessoryTableViewCell.h
//  JustForYou
//
//  Created by Антон on 22.04.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    kTopCornerRadius,
    kBottomCornerRadius
}BBKeyCornerRadius;

@interface BBAccessoryTableViewCell : UITableViewCell

@property (nonatomic) BOOL setRadius;

@end
