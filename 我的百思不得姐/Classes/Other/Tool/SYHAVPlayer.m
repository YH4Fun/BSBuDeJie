//
//  SYHAVPlayer.m
//  我的百思不得姐
//
//  Created by 孙英豪 on 16/4/11.
//  Copyright © 2016年 孙英豪. All rights reserved.
//

#import "SYHAVPlayer.h"


@interface SYHAVPlayer ()

/** AVPlayer */
@property (nonatomic,strong)AVPlayer *player;

@end

@implementation SYHAVPlayer
SingleM(SYHAVPlayer)
- (AVPlayer *)player{
    if (!_player) {
        _player = [[AVPlayer alloc] init];
    }
    return _player;
}

-(AVPlayer *)syh_playWithURLString:(NSString *)URLstr{
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:URLstr]];
    [self.player replaceCurrentItemWithPlayerItem:item];
    return self.player;
}

@end
