//
//  mainView.m
//  ASDKTest
//
//  Created by v.q on 2017/1/11.
//  Copyright © 2017年 Victor Qi. All rights reserved.
//

#import "mainView.h"

@implementation mainView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        mainNode *node = [[mainNode alloc]initWithFollowingModel:[FLDiscoveryModel setupModel]];
        node.frame = frame;
        node.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubnode:node];
    }
    
    return self;
}

@end
