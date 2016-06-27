//
//  SYHCommentHeaderView.m
//  我的百思不得姐
//
//  Created by 孙英豪 on 16/5/5.
//  Copyright © 2016年 孙英豪. All rights reserved.
//

#import "SYHCommentHeaderView.h"

@interface SYHCommentHeaderView ()
/** 内部的Label */
@property (nonatomic ,weak)UILabel *label;
@end

@implementation SYHCommentHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = SYHCommonBgColor;
        
        UILabel *label = [[UILabel alloc] init];
        label.x = SYHMargin * 0.5;
        label.textColor = SYHColor(120, 120, 120);
        label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        label.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:label];
        self.label = label;
    }
    return self;
}

- (void)setText:(NSString *)text{
    _text = [text copy];
    self.label.text = text;
}

@end
