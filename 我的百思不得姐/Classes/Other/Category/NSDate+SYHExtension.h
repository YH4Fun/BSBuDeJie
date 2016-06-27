//
//  NSDate+SYHExtension.h
//  我的百思不得姐
//
//  Created by 孙英豪 on 16/2/19.
//  Copyright © 2016年 孙英豪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (SYHExtension)

- (NSDateComponents *)intervalToDate:(NSDate *)date;
- (NSDateComponents *)intervalToNow;

- (BOOL)isThisYear;
- (BOOL)isToday;
- (BOOL)isYesterday;

@end
