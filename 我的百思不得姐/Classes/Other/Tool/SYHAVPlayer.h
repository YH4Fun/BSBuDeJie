//
//  SYHAVPlayer.h
//  我的百思不得姐
//
//  Created by 孙英豪 on 16/4/11.
//  Copyright © 2016年 孙英豪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "Singleton.h"

@interface SYHAVPlayer : NSObject

- (AVPlayer *)syh_playWithURLString:(NSString *)URLstr;

SingleH(SYHAVPlayer)
@end
