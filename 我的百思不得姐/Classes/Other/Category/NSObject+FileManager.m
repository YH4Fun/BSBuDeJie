//
//  NSObject+FileManager.m
//  我的百思不得姐
//
//  Created by 孙英豪 on 15/12/21.
//  Copyright © 2015年 孙英豪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+FileManager.h"


@implementation NSObject (FileManager)

+(NSString *)cachePath
{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
}

-(NSString *)cachePath
{
    return [NSObject cachePath];
}

- (void)getFileCacheSizeWithPath:(NSString *)path completion:(void(^)(NSInteger total))completion
{
    [NSObject getFileCacheSizeWithPath:path completion:completion];
}

+ (void)getFileCacheSizeWithPath:(NSString *)path completion:(void (^)(NSInteger))completion
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSFileManager *mgr = [NSFileManager defaultManager];
        BOOL isDirectory;
        BOOL isExists = [mgr fileExistsAtPath:path isDirectory:&isDirectory];
        
        if (isExists) {
            
            NSInteger total = 0;
            
            if (isDirectory) {
                NSArray *subpaths = [mgr subpathsAtPath:path];
//                NSLog(@"%@",path);
                
                for (NSString *subpath in subpaths) {
                    NSString *filePath = [path stringByAppendingPathComponent:subpath];
                    BOOL isDirctory;
                    BOOL isFileExists = [mgr fileExistsAtPath:filePath isDirectory:&isDirctory];
                    
                    if (isFileExists && !isDirctory && ![filePath containsString:@"DS"]) {
                        
                        NSDictionary *fileAttr = [mgr attributesOfItemAtPath:filePath error:nil];
                        total += [fileAttr[NSFileSize] integerValue];
                    }
                }
                
            }else{
                NSDictionary *fileAttr = [mgr attributesOfItemAtPath:path error:nil];
                total = [fileAttr[NSFileSize] integerValue];
            }
            dispatch_sync(dispatch_get_main_queue(), ^{
                if(completion){
                    completion(total);
                }
            });
        }
        
    });
}

- (void)removeCacheWithCompletion:(void (^)())completion
{
    [NSObject removeCacheWithCompletion:completion];
}

+ (void)removeCacheWithCompletion:(void (^)())completion
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *path = self.cachePath;
        NSFileManager *mgr = [NSFileManager defaultManager];
        BOOL isDirectory;
        BOOL isExits = [mgr fileExistsAtPath:path isDirectory:&isDirectory];
        if(!isExits)return ;
        if (isDirectory) {
            NSArray *subPaths = [mgr subpathsAtPath:path];
            for (NSString *subPath in subPaths) {
                NSString *filePath = [path stringByAppendingPathComponent:subPath];
                [mgr removeItemAtPath:filePath error:nil];
            }
        }
        dispatch_sync(dispatch_get_main_queue(), ^{
            if (completion) {
                completion();
            }
        });
    });
}


@end
