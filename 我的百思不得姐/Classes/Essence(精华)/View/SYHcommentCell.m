//
//  SYHcommentCell.m
//  我的百思不得姐
//
//  Created by 孙英豪 on 16/5/5.
//  Copyright © 2016年 孙英豪. All rights reserved.
//

#import "SYHcommentCell.h"
#import "SYHComment.h"
//#import "UIImageView+Header.h"
#import "SYHUser.h"

@interface SYHcommentCell ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sexView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLbel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *voiceButton;

@end

@implementation SYHcommentCell

- (void)awakeFromNib {

    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}

- (void)setComment:(SYHComment *)comment{
    _comment = comment;
    if (comment.voiceuri.length) {
        self.voiceButton.hidden = NO;
        [self.voiceButton setTitle:[NSString stringWithFormat:@"%zd""",comment.voicetime] forState:UIControlStateNormal];
    }else{
        self.voiceButton.hidden = YES;
    }
    [self.profileImageView SUN_setHeader:comment.user.profile_image];
    self.userNameLabel.text = comment.user.username;
    self.contentLabel.text = comment.content;
    self.likeCountLbel.text = [NSString stringWithFormat:@"%zd",comment.like_count];
    if ([comment.user.sex isEqualToString:SYHUserSexMale]) {
        self.sexView.image = [UIImage imageNamed:@"Profile_manIcon"];
    }else{
        self.sexView.image = [UIImage imageNamed:@"Profile_womanIcon"];
    }
}
@end
