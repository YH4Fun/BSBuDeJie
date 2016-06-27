//
//  SYHTopicVoiceView.m
//  我的百思不得姐
//
//  Created by 孙英豪 on 16/2/28.
//  Copyright © 2016年 孙英豪. All rights reserved.
//

#import "SYHTopicVoiceView.h"
#import "SYHTopic.h"
#import <UIImageView+WebCache.h>
//#import "SYHAVPlayer.h"
#import <AVFoundation/AVFoundation.h>

@interface SYHTopicVoiceView ()

@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *voiceTimeLabel;

/** AVPlayer */
@property (nonatomic,strong)AVPlayer *player;


@end

@implementation SYHTopicVoiceView

// AVPlayer懒加载
- (AVPlayer *)player{
    if (!_player) {
        _player = [[AVPlayer alloc]initWithURL:[NSURL URLWithString:self.topic.voiceuri]];
    }
    return _player;
}

- (void)setTopic:(SYHTopic *)topic{
    [super setTopic:topic];
    
    [_syh_imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    self.playCountLabel.text = [NSString stringWithFormat:@" %zd播放 ",topic.playcount];
    NSInteger min = topic.voicetime / 60;
    NSInteger sec =  topic.voicetime % 60;
    self.voiceTimeLabel.text = [NSString stringWithFormat:@" %02zd:%02zd ",min,sec];

}

- (IBAction)playButton:(UIButton *)button {
//    SYHLog(@"%@",self.topic.voiceuri);
    if (button.selected) {
        button.selected = NO;
        [self.player pause];
    }else{
        button.selected = YES;
        [self.player play];
    };
    
    
}


@end
