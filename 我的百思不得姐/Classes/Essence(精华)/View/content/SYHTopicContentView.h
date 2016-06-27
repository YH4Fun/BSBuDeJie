//
//  SYHTopicContentView.h
//  我的百思不得姐
//
//  Created by 孙英豪 on 16/2/26.
//  Copyright © 2016年 孙英豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SYHTopic;

@interface SYHTopicContentView : UIView

{
    __weak UIImageView *_syh_imageView;
}

/** 帖子模型 */
@property (nonatomic,strong)SYHTopic *topic;


@end
