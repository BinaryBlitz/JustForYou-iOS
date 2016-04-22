//
//  BBAccessoryTableViewCell.h
//  JustForYou
//
//  Created by Антон on 22.04.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    kNoneCornerRadius,
    kTopCornerRadius,
    kBottomCornerRadius,
    kAllCornerRadius
}BBKeyCornerRadius;

@interface BBAccessoryTableViewCell : UITableViewCell

@property (nonatomic) BOOL setRadius;
@property (nonatomic) BBKeyCornerRadius kSideCornerRadius;

@end
