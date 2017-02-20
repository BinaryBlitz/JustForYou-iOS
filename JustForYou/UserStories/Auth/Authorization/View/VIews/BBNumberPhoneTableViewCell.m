

#import "BBValidationService.h"

@interface BBNumberPhoneTableViewCell () <UITextFieldDelegate>

@end

@implementation BBNumberPhoneTableViewCell

- (void)awakeFromNib {
  [super awakeFromNib];
  self.validationOk = NO;
  self.numberTextField.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
  NSString *totalString = [NSString stringWithFormat:@"%@%@", textField.text, string];
  if (textField.text.length < 14) {
    self.validationOk = NO;
  } else {
    self.validationOk = YES;
  }
  if (range.length == 1) {
    textField.text = [BBValidationService validateNumberPhoneWithNumber:totalString deleteLastChar:YES];
  } else {
    textField.text = [BBValidationService validateNumberPhoneWithNumber:totalString deleteLastChar:NO];
  }
  if (self.validationOk) {
    if ([self.delegate respondsToSelector:@selector(numberPhoneValidate)]) {
      [self.delegate numberPhoneValidate];
    }
  }
  return NO;
}

@end
