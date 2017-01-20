//
//  FLNewSupplementaryNode.m
//  ASDKTest
//
//  Created by v.q on 2017/1/12.
//  Copyright © 2017年 Victor Qi. All rights reserved.
//

#import "FLNewSupplementaryNode.h"
#import "Utilities.h"

static const CGFloat kInsets = 10.0;

@interface FLNewSupplementaryNode ()
@property (nonatomic, strong) ASTextNode *textNode;
@end

@implementation FLNewSupplementaryNode
#pragma mark - Designed Initializer
- (instancetype)initWithText:(NSString *)text {
    if (self = [super init]) {
        self.backgroundColor = RGB(255.0, 249.0, 215.0);
        
        _textNode = [[ASTextNode alloc]init];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        paragraphStyle.alignment = NSTextAlignmentCenter;
        _textNode.attributedText = [[NSAttributedString alloc]
             initWithString:text
              attributes:@{
                           NSForegroundColorAttributeName: RGB(91, 91, 91),
                           NSFontAttributeName: [UIFont systemFontOfSize:11*ScreenHeightRatio weight:UIFontWeightLight],
                           NSParagraphStyleAttributeName: paragraphStyle,
                           }];
        [self addSubnode:_textNode];
    }
    
    return self;
}

#pragma mark - Layout
- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize {
    ASCenterLayoutSpec *center = [[ASCenterLayoutSpec alloc] init];
    center.centeringOptions = ASCenterLayoutSpecCenteringXY;
    center.child = [self.textNode styledWithBlock:^(__kindof ASLayoutElementStyle * _Nonnull style) {
        style.flexShrink = 1.0;
    }];
    UIEdgeInsets insets = UIEdgeInsetsMake(kInsets, kInsets, kInsets, kInsets);
    
    return [ASInsetLayoutSpec insetLayoutSpecWithInsets:insets child:center];
}

@end
