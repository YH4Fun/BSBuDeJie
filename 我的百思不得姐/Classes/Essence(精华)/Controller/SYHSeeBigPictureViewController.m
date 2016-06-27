//
//  SYHSeeBigPictureViewController.m
//  我的百思不得姐
//
//  Created by 孙英豪 on 16/3/8.
//  Copyright © 2016年 孙英豪. All rights reserved.
//

#import "SYHSeeBigPictureViewController.h"
#import "SYHTopic.h"
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>
#import <Photos/Photos.h>

@interface SYHSeeBigPictureViewController ()<UIScrollViewDelegate>

/** imageView */
@property (nonatomic ,weak)UIImageView *imageVeiw;

@end

@implementation SYHSeeBigPictureViewController

static NSString *SYHAssetCollectionTitle = @"百思";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = [UIScreen mainScreen].bounds;
    scrollView.backgroundColor = [UIColor blackColor];
    scrollView.delegate = self;
    [self.view insertSubview:scrollView atIndex:0];
    
    UIImageView *imgView = [[UIImageView alloc] init];
    [imgView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image]];
    [scrollView addSubview:imgView];
    self.imageVeiw = imgView;
    imgView.x = 0;
    imgView.width = SYHScreenW;
    imgView.height = imgView.width / self.topic.width * self.topic.height;
    if (imgView.height > SYHScreenH) {
        imgView.y = 0;
        scrollView.contentSize = CGSizeMake(0, imgView.height);
    }else{
        imgView.centerY = SYHScreenH / 2;
    }
    
    CGFloat maxScale = self.topic.width / SYHScreenW;
    if (self.topic.width > SYHScreenW) {
        scrollView.maximumZoomScale = maxScale;
    }
    // 给imgView添加点按手势
    imgView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back:)];
    [imgView addGestureRecognizer:tap];
    
}

  // 返回按钮
- (IBAction)back:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 保存按钮
- (IBAction)save:(UIButton *)sender {
    // 判断授权
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    switch (status) {
        case PHAuthorizationStatusRestricted:  // 家长控制
            [SVProgressHUD showErrorWithStatus:@"由于系统原因,无法访问相册,请关闭家长控制功能再尝试"];
            break;
        case PHAuthorizationStatusAuthorized:  // 允许授权
            // 保存图片
            [self saveImage];
            break;
        case PHAuthorizationStatusDenied:      // 拒绝授权
            [SVProgressHUD showErrorWithStatus:@"请打开本应用的\n照片访问开关!"];
            break;
        case PHAuthorizationStatusNotDetermined:  // 未确定授权,用户还没做出选择
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                if (status == PHAuthorizationStatusAuthorized) {
                    // 保存图片
                    [self saveImage];
                }else{
                    [SVProgressHUD showErrorWithStatus:@"图片保存失败!"];
                }
            }];
            break;
            
    }
}

// 保存图片
- (void)saveImage{
    __block NSString *assetLocalIdentifier = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        assetLocalIdentifier = [PHAssetCreationRequest creationRequestForAssetFromImage:self.imageVeiw.image].placeholderForCreatedAsset.localIdentifier;
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (success == NO) {
            [self showError:@"保存失败"];
            return ;
        }
        // 获得相册
        PHAssetCollection *createCollection = [self creatAssetCollection];
        if (createCollection == nil) {
            [self showError:@"相册创建失败"];
            return;
        }
        
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:createCollection];
            PHAsset *asset = [PHAsset fetchAssetsWithLocalIdentifiers:@[assetLocalIdentifier] options:nil].lastObject;
            [request addAssets:@[asset]];
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                [self showSuccess:@"保存成功"];
            }else{
                [self showError:@"保存失败"];
            }
        }];
    }];
    
}

- (PHAssetCollection *)creatAssetCollection{
    // 遍历查找文件夹
    PHFetchResult<PHAssetCollection *> *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    for (PHAssetCollection *assetCollection in assetCollections) {
        if ([assetCollection.localizedTitle isEqualToString:SYHAssetCollectionTitle]) {
            return assetCollection;
        }
    }
    // 没有找到,创建文件夹
    NSError *error = nil;
    __block NSString *collectionLocalIdentifier = nil;
    
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        collectionLocalIdentifier = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:SYHAssetCollectionTitle].placeholderForCreatedAssetCollection.localIdentifier;
    } error:&error];
    if (error) return nil;
    
    return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[collectionLocalIdentifier] options:nil].lastObject;
}


// 保存失败
- (void)showSuccess:(NSString *)text{
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD showErrorWithStatus:text];
    });
}
// 保存成功
- (void)showError:(NSString *)text{
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD showErrorWithStatus:text];
    });
}
// 状态栏白色
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageVeiw;
}
#pragma mark - 3DTouch预览上拉标签
-(NSArray<id<UIPreviewActionItem>> *)previewActionItems{
    UIPreviewAction *action = [UIPreviewAction actionWithTitle:@"保存" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        [self save:nil];
    }];
    return @[action];
}


@end
