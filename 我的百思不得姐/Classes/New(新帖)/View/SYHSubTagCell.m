//
//  SYHSubTagCell.m
//  我的百思不得姐
//
//  Created by 孙英豪 on 15/12/19.
//  Copyright © 2015年 孙英豪. All rights reserved.
//

#import "SYHSubTagCell.h"
#import "SYHSubTagItem.h"

#import "UIImage+Antialias.h"

#import <UIImageView+WebCache.h>


@interface SYHSubTagCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;


@end
@implementation SYHSubTagCell

-(void)setItem:(SYHSubTagItem *)item
{
    _item = item;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:item.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
//        UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
//        CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
//        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
//        [path addClip];
//        [image drawAtPoint:CGPointZero];
//        image = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
        
        self.iconView.image = [image SUN_circleImage];
        
    }];
    self.nameLabel.text = item.theme_name;
    
    NSInteger num = [item.sub_number integerValue];
    NSString *numStr = [NSString stringWithFormat:@"%ld人订阅",num];
    if (num > 10000) {
        numStr = [NSString stringWithFormat:@"%.1f万人订阅",num / 10000.0];
        
    }
    
    self.numberLabel.text = numStr;
}


- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 1;
    [super setFrame:frame];
}

- (void)awakeFromNib {
    // Initialization code
    
//    NSLog(@"%@",self.layoutMargins);

//    self.separatorInset = UIEdgeInsetsZero;
//    self.layoutMargins = UIEdgeInsetsZero;
    
    
//    self.iconView.layer.cornerRadius = self.iconView.width * 0.5;
//    self.iconView.layer.masksToBounds = YES;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
