//
//  SYHTopicContentView.m
//  我的百思不得姐
//
//  Created by 孙英豪 on 16/2/26.
//  Copyright © 2016年 孙英豪. All rights reserved.
//

#import "SYHTopicContentView.h"
#import "SYHSeeBigPictureViewController.h"

@interface SYHTopicContentView ()<UIViewControllerPreviewingDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *syh_imageView;

@end

@implementation SYHTopicContentView

- (void)awakeFromNib{
    // 清除自动伸缩属性
    self.autoresizingMask = UIViewAutoresizingNone;
    
    self.syh_imageView.userInteractionEnabled = YES;
    [self.syh_imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(syh_imageViewClick)]];
    
    //注册3DTouch
    if (self.traitCollection.forceTouchCapability != UIForceTouchCapabilityUnavailable) {
        [[UIApplication sharedApplication].keyWindow.rootViewController registerForPreviewingWithDelegate:self sourceView:self.syh_imageView];
//        NSLog(@"3Dtouch");
    }
}

- (void)syh_imageViewClick{
    if (self.syh_imageView.image == nil) return;
    SYHSeeBigPictureViewController *seeBig = [[SYHSeeBigPictureViewController alloc] init];
    seeBig.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:seeBig animated:YES completion:nil];
}

#pragma mark - UIViewControllerPreviewingDelegate
- (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location{
    if (self.syh_imageView.image == nil) return nil;
    SYHSeeBigPictureViewController *seeBig = [[SYHSeeBigPictureViewController alloc] init];
    seeBig.topic = self.topic;
    previewingContext.sourceRect = CGRectMake(self.syh_imageView.frame.origin.x, self.syh_imageView.frame.origin.y, self.syh_imageView.frame.size.width, self.syh_imageView.frame.size.height);
    return seeBig;
}

- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit{
    [[UIApplication sharedApplication].keyWindow.rootViewController showViewController:viewControllerToCommit sender:self];
}

@end

