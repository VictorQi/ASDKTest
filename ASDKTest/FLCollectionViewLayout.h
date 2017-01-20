//
//  FLNewRecommendFollowingFlowLayout.h
//  ASDKTest
//
//  Created by v.q on 2017/1/14.
//  Copyright © 2017年 Victor Qi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AsyncDisplayKit/AsyncDisplayKit.h>

@interface FLCollectionViewLayout : UICollectionViewLayout

@property (nonatomic, assign) NSUInteger numberOfColumns;
@property (nonatomic, assign) CGFloat columnSpacing;
@property (nonatomic, assign) UIEdgeInsets sectionInset;
@property (nonatomic, assign) UIEdgeInsets interItemSpacing;
@property (nonatomic, assign) CGFloat headerHeight;

@end

@protocol FLCollectionViewLayoutDelegate <ASCollectionDelegate>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout originalItemSizeAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface FLCollectionViewLayoutInspector : NSObject <ASCollectionViewLayoutInspecting>

@end
