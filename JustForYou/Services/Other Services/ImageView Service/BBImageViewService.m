
#import <SDWebImage/UIImageView+WebCache.h>

static NSString *kNameFormat = @"cache";

@implementation BBImageViewService

+ (instancetype)sharedService {
  static BBImageViewService *service = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    service = [[BBImageViewService alloc] init];
  });
  return service;
}

- (void)setImageForImageView:(BBImageWithLoader *)imageView placeholder:(UIImage *)placeholder stringURL:(NSString *)url {
//    [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder];
  imageView.indicatorView.hidden = NO;
  if (!imageView.indicatorView.isAnimating) {
    [imageView.indicatorView startAnimating];
  }
  [imageView sd_setImageWithURL:[NSURL URLWithString:url]
               placeholderImage:nil
                      completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                        imageView.indicatorView.hidden = YES;
                        [imageView.indicatorView stopAnimating];
                      }];
}

@end
