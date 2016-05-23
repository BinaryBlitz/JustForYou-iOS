//
//  BBDottedBorderButton.h
//  JustForYou
//
//  Created by Антон on 22.04.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum tagBorderType
{
    BorderTypeDashed,
    BorderTypeSolid
}BorderType;

@interface BBDottedBorderButton : UIButton

@property (strong, nonatomic) CAShapeLayer *shapeLayer;
@property (assign, nonatomic) BorderType borderType;
@property (assign, nonatomic) CGFloat cornerRadius;
@property (assign, nonatomic) CGFloat borderWidth;
@property (assign, nonatomic) NSUInteger dashPattern;
@property (assign, nonatomic) NSUInteger spacePattern;
@property (strong, nonatomic) UIColor *borderColor;

@end
