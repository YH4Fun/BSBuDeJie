//
//  SYHAdItem.h
//  我的百思不得姐
//
//  Created by 孙英豪 on 15/12/18.
//  Copyright © 2015年 孙英豪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYHAdItem : NSObject
//广告图片
@property (nonatomic,strong)NSString *w_picurl;
//点击广告图片跳转链接
@property (nonatomic,strong)NSString *ori_curl;

@property (nonatomic, assign) CGFloat w;

@property (nonatomic, assign) CGFloat h;

@end
