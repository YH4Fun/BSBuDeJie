//
//  NSObject+FileManager.h
//  我的百思不得姐
//
//  Created by 孙英豪 on 15/12/21.
//  Copyright © 2015年 孙英豪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (FileManager)

+ (NSString *)cachePath;
- (NSString *)cachePath;

+ (void)getFileCacheSizeWithPath:(NSString *)path completion:(void(^)(NSInteger total))completion;
- (void)getFileCacheSizeWithPath:(NSString *)path completion:(void(^)(NSInteger total))completion;

+ (void)removeCacheWithCompletion:(void(^)())completion;
- (void)removeCacheWithCompletion:(void(^)())completion;

@end
