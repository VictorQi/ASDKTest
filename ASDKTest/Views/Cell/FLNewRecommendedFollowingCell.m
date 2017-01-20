//
//  FLNewRecomandedFollowingCell.m
//  ASDKTest
//
//  Created by v.q on 2017/1/12.
//  Copyright © 2017年 Victor Qi. All rights reserved.
//

#import "FLNewRecommendedFollowingCell.h"
#import "FLDiscoveryModel.h"
#import "NSString+TransformNum.h"
#import "Utilities.h"

@interface FLNewRecommendedFollowingCell ()

@property (nonatomic, strong) ASNetworkImageNode *avatarNode;
@property (nonatomic, strong) ASImageNode *badgeNode;
@property (nonatomic, strong) ASImageNode *shadowNode;
@property (nonatomic, strong) ASTextNode  *nameNode;
@property (nonatomic, strong) ASImageNode *prefixImageNode;
@property (nonatomic, strong) ASTextNode  *numbersNode;

@end

@implementation FLNewRecommendedFollowingCell
#pragma mark - Designed Initializer
- (instancetype)initWithFollowingModel:(FLDiscoveryModel *)model {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        
        _shadowNode = [[ASImageNode alloc]init];
        _shadowNode.image = [UIImage imageNamed:@"shadow"];
        _shadowNode.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubnode:_shadowNode];
        
        _avatarNode = [[ASNetworkImageNode alloc]init];
        _avatarNode.defaultImage = [UIImage imageNamed:@"livelist_icon_placeholder"];
        _avatarNode.URL = [NSURL URLWithString:model.avatar_small];
        _avatarNode.placeholderFadeDuration = 0.15;
        _avatarNode.contentMode = UIViewContentModeScaleAspectFill;
        _avatarNode.imageModificationBlock = ^UIImage *(UIImage *image) {
            if (!image) {return nil;}
            CGRect rect = (CGRect){CGPointZero, image.size};
            UIGraphicsBeginImageContextWithOptions(image.size, false, 0); {
                UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
                [path addClip];
                [image drawInRect:rect blendMode:kCGBlendModeNormal alpha:1.0];
            }
            UIImage *modifiedImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            return modifiedImage ? : image;
        };
        [self addSubnode:_avatarNode];
        
        _badgeNode = [[ASImageNode alloc]init];
//        _badgeNode.image = [UIImage imageNamed:@"recommend_select"];
        _badgeNode.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubnode:_badgeNode];
        
        _nameNode = [[ASTextNode alloc]init];
        _nameNode.maximumNumberOfLines = 0;
        _nameNode.truncationMode = NSLineBreakByWordWrapping;
        _nameNode.attributedText = [[NSAttributedString alloc]
                                    initWithString:NICK_SAFE(model.nick, model.uid)
                                    attributes:@{
                                                 NSForegroundColorAttributeName: RGB(102.0, 102.0, 102.0),
                                                 NSFontAttributeName: [UIFont systemFontOfSize:9.0*ScreenHeightRatio]
                                                 }];
        [self addSubnode:_nameNode];
        
        _prefixImageNode = [[ASImageNode alloc]init];
        _prefixImageNode.image = [UIImage imageNamed:@"followerNumber"];
        [self addSubnode:_prefixImageNode];
        
        NSString *followCount = [model.follower_count transformNumIfNeeded];
        _numbersNode = [[ASTextNode alloc]init];
        _numbersNode.attributedText = [[NSAttributedString alloc]
                                       initWithString:followCount
                                       attributes:@{
                                                    NSForegroundColorAttributeName: RGB(153.0, 153.0, 153.0),
                                                    NSFontAttributeName: [UIFont systemFontOfSize:6.75*ScreenHeightRatio]
                                                    }];
        [self addSubnode:_numbersNode];
    }
    
    return self;
}

#pragma mark - Layout
- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize {
    self.prefixImageNode.style.preferredSize = CGSizeMake(8*ScreenWidthRatio, 6*ScreenWidthRatio);
    
    self.avatarNode.style.preferredSize = CGSizeMake(55.0*ScreenWidthRatio, 55.0*ScreenWidthRatio);
    self.avatarNode.style.layoutPosition = CGPointMake(0.0, 0.0);
    self.badgeNode.style.preferredSize = CGSizeMake(14.5*ScreenWidthRatio, 14.5*ScreenWidthRatio);
    self.badgeNode.style.layoutPosition = CGPointMake(40.5*ScreenWidthRatio, 40.5*ScreenWidthRatio);
    ASAbsoluteLayoutSpec *avatarAbsoluteSpec = [ASAbsoluteLayoutSpec absoluteLayoutSpecWithSizing:ASAbsoluteLayoutSpecSizingSizeToFit children:@[self.avatarNode, self.badgeNode]];
    
    self.shadowNode.style.preferredSize = CGSizeMake(63*ScreenWidthRatio, 64*ScreenWidthRatio);
    self.shadowNode.style.layoutPosition = CGPointMake(-4.0*ScreenWidthRatio, 0.0);
    ASAbsoluteLayoutSpec *avatarWithShadowAbsSpec = [ASAbsoluteLayoutSpec absoluteLayoutSpecWithSizing:ASAbsoluteLayoutSpecSizingSizeToFit children:@[avatarAbsoluteSpec, self.shadowNode]];
    
    ASInsetLayoutSpec *avatarInsetsSpec = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(30.0, 0.0, 0.0, 0.0) child:avatarWithShadowAbsSpec];
    
    ASStackLayoutSpec *followerNumbersStackSpec = [ASStackLayoutSpec horizontalStackLayoutSpec];
    followerNumbersStackSpec.spacing = 4.0;
    followerNumbersStackSpec.justifyContent = ASStackLayoutJustifyContentStart;
    followerNumbersStackSpec.alignItems = ASStackLayoutAlignItemsCenter;
    followerNumbersStackSpec.children = @[self.prefixImageNode, [self.numbersNode styledWithBlock:^(__kindof ASLayoutElementStyle * _Nonnull style) {
        style.flexShrink = 1.0;
    }]];
    
    ASStackLayoutSpec *textVerticalStackSpec = [ASStackLayoutSpec verticalStackLayoutSpec];
    textVerticalStackSpec.spacing = 5.0;
    textVerticalStackSpec.alignItems = ASStackLayoutAlignItemsCenter;
    textVerticalStackSpec.children = @[self.nameNode, followerNumbersStackSpec];
    
    ASLayoutSpec *verticalSpacing = [[ASLayoutSpec alloc]init];
    verticalSpacing.style.flexGrow = 1.0;
    
    ASStackLayoutSpec *verticalStackLayoutSpec = [ASStackLayoutSpec verticalStackLayoutSpec];
    verticalStackLayoutSpec.spacing = 0.0;
    verticalStackLayoutSpec.alignItems = ASStackLayoutAlignItemsCenter;
    verticalStackLayoutSpec.children = @[avatarInsetsSpec, verticalSpacing, textVerticalStackSpec];
    
    ASCenterLayoutSpec *centerLayoutSpec = [ASCenterLayoutSpec centerLayoutSpecWithCenteringOptions:ASCenterLayoutSpecCenteringX sizingOptions:ASCenterLayoutSpecSizingOptionDefault child:verticalStackLayoutSpec];
    
    return centerLayoutSpec;
}

#pragma mark - Did Load 
- (void)didLoad {
    [super didLoad];
    
    [self setSelected:YES];
}

#pragma mark - Seleted
- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    self.badgeNode.image = selected ? [UIImage imageNamed:@"recommend_select"] : [UIImage imageNamed:@"recommend_noselect"];
}
@end
