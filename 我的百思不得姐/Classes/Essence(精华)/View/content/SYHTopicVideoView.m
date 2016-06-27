//
//  SYHTopicVideoView.m
//  我的百思不得姐
//
//  Created by 孙英豪 on 16/2/28.
//  Copyright © 2016年 孙英豪. All rights reserved.
//

#import "SYHTopicVideoView.h"
#import "SYHTopic.h"
#import <UIImageView+WebCache.h>
//#import <MediaPlayer/MediaPlayer.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

@interface SYHTopicVideoView ()
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *videoTimeLabel;

@end


@implementation SYHTopicVideoView

- (void)setTopic:(SYHTopic *)topic{
    [super setTopic:topic];
    
    [_syh_imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    self.playCountLabel.text = [NSString stringWithFormat:@" %zd播放 ",topic.playcount];
    NSInteger min = topic.videotime / 60;
    NSInteger sec =  topic.videotime % 60;
    self.videoTimeLabel.text = [NSString stringWithFormat:@" %02zd:%02zd ",min,sec];
    
}

// 视频播放
- (IBAction)playButton:(id)sender {
//    SYHLog(@"playButton--%@",self.topic.videouri);
//    MPMoviePlayerViewController *moviePlay = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:self.topic.videouri]];
//    
//    moviePlay.moviePlayer.controlStyle = MPMovieControlStyleFullscreen;
//    
//    [[UIApplication sharedApplication].keyWindow.rootViewController presentMoviePlayerViewControllerAnimated:moviePlay];
    AVPlayerViewController *playVC = [[AVPlayerViewController alloc] init];
    playVC.player = [[AVPlayer alloc] initWithURL:[NSURL URLWithString:self.topic.videouri]];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:playVC animated:YES completion:^{
        [playVC.player play];
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
