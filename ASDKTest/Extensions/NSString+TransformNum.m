//
//  NSString+TransformNum.m
//  SwiftLive
//
//  Created by 查俊松 on 2016/9/21.
//  Copyright © 2016年 DotC_United. All rights reserved.
//

#import "NSString+TransformNum.h"
#import <UIKit/UIKit.h>

@implementation NSString (TransformNum)

#pragma mark 将数字字符串转化成目标格式（最多显示5位数，超过后以xx.xK或者xx.xM的形式来显示）
- (NSString *)transformNumIfNeeded
{
    // 安全判断
    if (!self || !self.length) {
        return @"";
    }
    NSInteger num = [self integerValue];
    if (num < 0) {
        return @"";
    }
    // 开始转换
    if (num < 100000) {
        return self;
    } else if (num < 1000000) {
        CGFloat transformNum = num / 1000.0;
        NSString *targetNum = [NSString stringWithFormat:@"%.1fK", transformNum];
        return targetNum;
    } else {
        CGFloat transformNum = num / 1000000.0;
        NSString *targetNum = [NSString stringWithFormat:@"%.1fM", transformNum];
        return targetNum;
    }
}

@end
