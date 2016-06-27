//
//  SYHSquareCell.m
//  我的百思不得姐
//
//  Created by 孙英豪 on 15/12/21.
//  Copyright © 2015年 孙英豪. All rights reserved.
//

#import "SYHSquareCell.h"

#import "SYHSquareItem.h"

#import <UIImageView+WebCache.h>

@interface SYHSquareCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet UILabel *nameView;

@end

@implementation SYHSquareCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setItem:(SYHSquareItem *)item
{
    _item = item;
    _nameView.text = item.name;
    [_iconView sd_setImageWithURL:[NSURL URLWithString: item.icon]];
}


@end
