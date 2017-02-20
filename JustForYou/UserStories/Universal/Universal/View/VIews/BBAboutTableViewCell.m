

static NSString *firstParagraph = @"JUST FOR YOU – это проект, который специально создан для занятых жителей мегаполиса и объединяет медицинский подход к здоровому питанию со стандартами высокой кухни.\n\n";

static NSString *secondParagraph = @"JUST FOR YOU – это Ваш личный диетолог, который ежедневно обеспечивает Вас набором блюд с необходимым количество белков, жиров и углеводов в идеальном балансе суточных калорий!\n\n";

static NSString *thirdParagraph = @"JUST FOR YOU – это Ваш личный шеф- повар, который готовит блюда высокой кухни и делает здоровое питание по- настоящему вкусным!\n";

@implementation BBAboutTableViewCell

- (void)awakeFromNib {
  [super awakeFromNib];
  self.infoTextLabel.text = [NSString stringWithFormat:@"%@%@%@", firstParagraph, secondParagraph, thirdParagraph];
  // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];

  // Configure the view for the selected state
}

- (IBAction)goToWebsiteButtonAction:(id)sender {
  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://justforyou.ru"]];
}

@end
