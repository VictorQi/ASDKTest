//
//  NSString+TransformNum.h
//  SwiftLive
//
//  Created by 查俊松 on 2016/9/21.
//  Copyright © 2016年 DotC_United. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (TransformNum)

// 将数字字符串转化成目标格式（最多显示5位数，超过后以xx.xK或者xx.xM的形式来显示）
- (NSString *)transformNumIfNeeded;

@end
