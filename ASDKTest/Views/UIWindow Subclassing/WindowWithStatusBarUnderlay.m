//
//  WindowWithStatusBarUnderlay.m
//  ASDKTest
//
//  Created by v.q on 2017/1/12.
//  Copyright © 2017年 Victor Qi. All rights reserved.
//

#import "WindowWithStatusBarUnderlay.h"
#import "Utilities.h"

@implementation WindowWithStatusBarUnderlay {
    UIView *_statusBarOpaqueUnderlayView;
}

#pragma mark - Life Cycle
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _statusBarOpaqueUnderlayView = [[UIView alloc]init];
        _statusBarOpaqueUnderlayView.backgroundColor = [UIColor darkBlueColor];
    }
    
    return self;
}

#pragma mark - LayoutSubviews
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self bringSubviewToFront:_statusBarOpaqueUnderlayView];
    
    CGRect statusBarFrame              = CGRectZero;
    statusBarFrame.size.width          = [[UIScreen mainScreen] bounds].size.width;
    statusBarFrame.size.height         = [[UIApplication sharedApplication] statusBarFrame].size.height;
    _statusBarOpaqueUnderlayView.frame = statusBarFrame;
}

@end
