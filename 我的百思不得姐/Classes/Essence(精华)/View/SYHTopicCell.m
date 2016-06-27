//
//  SYHTopicCell.m
//  我的百思不得姐
//
//  Created by 孙英豪 on 15/12/25.
//  Copyright © 2015年 孙英豪. All rights reserved.
//

#import "SYHTopicCell.h"

#import "SYHTopic.h"
#import "SYHComment.h"
#import "SYHUser.h"

#import "SYHTopicPictureView.h"
#import "SYHTopicVideoView.h"
#import "SYHTopicVoiceView.h"
#import "SYHCommentViewController.h"

@class SYHTopicViewController;

@interface SYHTopicCell ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *text_label;

@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

/** 图片视图 */
@property (nonatomic ,weak)SYHTopicPictureView *pictureView;
/** 视频视图 */
@property (nonatomic ,weak)SYHTopicVideoView *videoView;
/** 声音视图 */
@property (nonatomic ,weak)SYHTopicVoiceView *voiceView;

/** 最热评论整体 */
@property (weak, nonatomic) IBOutlet UIView *topCmtView;

/** 最热评论-底部标题 */
@property (weak, nonatomic) IBOutlet UILabel *topCmtLabel;


@end

@implementation SYHTopicCell

// 懒加载图片view,视频view和声音view
- (SYHTopicPictureView *)pictureView{
    if (!_pictureView) {
        SYHTopicPictureView *picView = [SYHTopicPictureView viewFromXib];
        [self.contentView addSubview:picView];
        _pictureView = picView;
    }
    return _pictureView;
}

- (SYHTopicVideoView *)videoView{
    if (!_videoView) {
        SYHTopicVideoView *videoView = [SYHTopicVideoView viewFromXib];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}

- (SYHTopicVoiceView *)voiceView{
    if (!_voiceView) {
        SYHTopicVoiceView *voiceView = [SYHTopicVoiceView viewFromXib];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}

- (void)awakeFromNib {
    // Initialization code
    
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}

- (void)setTopic:(SYHTopic *)topic
{
    _topic = topic;
    
    [self.profileImageView SUN_setHeader:topic.profile_image];
    self.nameLabel.text = topic.name;
    self.createdAtLabel.text = topic.created_at;
    self.text_label.text = topic.text;
    
    
    [self setButtonTitleWithButton:self.dingButton number:topic.ding placehoder:@"顶"];
    [self setButtonTitleWithButton:self.caiButton number:topic.cai placehoder:@"踩"];
    [self setButtonTitleWithButton:self.repostButton number:topic.repost placehoder:@"分享"];
    [self setButtonTitleWithButton:self.commentButton number:topic.comment placehoder:@"评论"];
    
    // 根据帖子的类型决定中间内容
    if (topic.type == SYHTopicTypePicture) {   // 图片
        self.pictureView.hidden = NO;
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        self.pictureView.frame = topic.contentFrame;
        self.pictureView.topic = topic;
        
    }else if (topic.type == SYHTopicTypeVideo){  // 视频
        self.pictureView.hidden = YES;
        self.videoView.hidden = NO;
        self.voiceView.hidden = YES;
        self.videoView.frame = topic.contentFrame;
        self.videoView.topic = topic;
        
    }else if (topic.type == SYHTopicTypeVoice){  // 声音
        self.voiceView.hidden = NO;
        self.pictureView.hidden = YES;
        self.videoView .hidden = YES;
        self.voiceView.frame = topic.contentFrame;
        self.voiceView.topic = topic;
        
    }else if (topic.type == SYHTopicTypeWord){  // 文字
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
        self.videoView .hidden = YES;
    }
    
    
    //判断是否有最热评论
    if (topic.topComment) {
        self.topCmtView.hidden = NO;
        NSString *userName = topic.topComment.user.username;
        NSString *content = topic.topComment.content;
        self.topCmtLabel.text = [NSString stringWithFormat:@"%@ : %@", userName, content];
    }else{
        self.topCmtView.hidden = YES;
    }
    
}

- (void)setFrame:(CGRect)frame
{
    frame.size.height -= SYHMargin;
    [super setFrame:frame];
}

//设置工具条按钮文字
- (void)setButtonTitleWithButton:(UIButton *)button number:(NSInteger)number placehoder:(NSString *)placehoder
{
    if (number >= 10000) {
        [button setTitle:[NSString stringWithFormat:@"%.1f万",number / 10000.0] forState:UIControlStateNormal];
    }else if(number > 0){
        [button setTitle:[NSString stringWithFormat:@"%zd",number] forState:UIControlStateNormal];
    }else{
        [button setTitle:placehoder forState:UIControlStateNormal];
    }
}


- (IBAction)moreButtonClick:(UIButton *)sender {
    //    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"标题" message:@"message" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"收藏", nil];
    //    [alert show];
    //    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"标题" delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:@"destructive" otherButtonTitles: nil];
    //    [sheet showInView:self];
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [controller addAction:[UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了[收藏]按钮");
    }]];
    [controller addAction:[UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了[举报]按钮");
    }]];
    [controller addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了[取消]按钮");
    }]];
    
    
    [self.window.rootViewController presentViewController:controller animated:YES completion:nil];
    
}
// 点击评论按钮
- (IBAction)commentButtonClick:(id)sender {
    
//    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:self,@"SYHTopicCell" ,nil];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"cellCommentButtonClick" object:[self class] userInfo:dict];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
