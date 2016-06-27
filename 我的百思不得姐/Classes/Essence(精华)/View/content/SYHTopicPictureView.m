//
//  SYHTopicPictureView.m
//  我的百思不得姐
//
//  Created by 孙英豪 on 16/2/26.
//  Copyright © 2016年 孙英豪. All rights reserved.
//

#import "SYHTopicPictureView.h"
#import <UIImageView+WebCache.h>
#import "SYHTopic.h"
#import <DALabeledCircularProgressView.h>

@interface SYHTopicPictureView ()
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigPictureButton;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressVeiw;


@end

@implementation SYHTopicPictureView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.progressVeiw.roundedCorners = 5;
    self.progressVeiw.progressLabel.textColor = [UIColor whiteColor];
    self.seeBigPictureButton.userInteractionEnabled = NO;
}

- (void)setTopic:(SYHTopic *)topic{
    [super setTopic:topic];
    
    SYHWeakSelf;
    self.progressVeiw.progress = 0; // 有时网速慢下载进度会显示"-0%"
    [_syh_imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//        SYHLog(@"请求到图片");
        weakSelf.progressVeiw.hidden = NO;
        weakSelf.progressVeiw.progress = 1.0 * receivedSize / expectedSize;
        weakSelf.progressVeiw.progressLabel.text = [NSString stringWithFormat:@"%.0f%%",weakSelf.progressVeiw.progress * 100];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        SYHLog(@"图片请求完成,%s",__FUNCTION__);
        weakSelf.progressVeiw.hidden = YES;
    }];
    
    self.gifView.hidden = !topic.is_gif;
    self.seeBigPictureButton.hidden = !topic.isBigPicture;
    if (topic.isBigPicture) {
        _syh_imageView.contentMode = UIViewContentModeTop;
        _syh_imageView.clipsToBounds = YES;
    }else{
        _syh_imageView.contentMode = UIViewContentModeScaleToFill;
        _syh_imageView.clipsToBounds = NO;
        
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
