//
//  mainNode.h
//  ASDKTest
//
//  Created by v.q on 2017/1/11.
//  Copyright © 2017年 Victor Qi. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import "FLDiscoveryModel.h"

@interface mainNode : ASDisplayNode

- (instancetype)initWithFollowingModel:(FLDiscoveryModel *)model;

@end
