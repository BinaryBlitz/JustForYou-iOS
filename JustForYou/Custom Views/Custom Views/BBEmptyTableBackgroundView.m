//
//  BBEmptyTableBackgroundView.m
//  JustForYou
//
//  Created by Алексей on 09.08.17.
//  Copyright © 2017 BinaryBlitz. All rights reserved.
//

#import "BBEmptyTableBackgroundView.h"

@implementation BBEmptyTableBackgroundView

- (IBAction)buttonDidTap:(id)sender {
  if (self.buttonHandler != nil) {
    self.buttonHandler();
  }
}

- (void)layoutSubviews {
  [super layoutSubviews];
  self.button.layer.cornerRadius = self.button.frame.size.height / 2;
}
@end
