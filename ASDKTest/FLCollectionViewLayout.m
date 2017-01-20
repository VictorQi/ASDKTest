//
//  FLNewRecommendFollowingFlowLayout.m
//  ASDKTest
//
//  Created by v.q on 2017/1/14.
//  Copyright © 2017年 Victor Qi. All rights reserved.
//

#import "FLCollectionViewLayout.h"

#pragma mark - 
#pragma mark - FLCollectionViewLayout Implementation
@implementation FLCollectionViewLayout {
    NSMutableArray *_columnHeights;
    NSMutableArray *_itemAttributes;
    NSMutableDictionary *_headerAttributes;
    NSMutableArray *_allAttributes;
}

#pragma mark - Life Cycle
- (instancetype)init {
    self = [super init];
    if (self != nil) {
        // set default value
        _numberOfColumns = 3;
        _columnSpacing = 10.0;
        _sectionInset = UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0);
        _interItemSpacing = UIEdgeInsetsMake(10.0, 0.0, 10.0, 0.0);
    }
    
    return self;
}

#pragma mark - Prepare for layout
- (void)prepareLayout {
    _itemAttributes = [NSMutableArray array];
    _columnHeights = [NSMutableArray array];
    _allAttributes = [NSMutableArray array];
    _headerAttributes = [NSMutableDictionary dictionary];
    
    CGFloat top = 0.0;
    
    NSInteger myNumberOfSections = [self.collectionView numberOfSections];
    for (NSUInteger section = 0; section < myNumberOfSections; section++) {
        NSInteger numberOfItems = [self.collectionView numberOfItemsInSection:section];
        
        top += _sectionInset.top;
        
        if (_headerHeight > 0) {
            CGSize headerSize = [self _headerSizeForSection:section];
            UICollectionViewLayoutAttributes *attributes =
            [UICollectionViewLayoutAttributes
                 layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                 withIndexPath:[NSIndexPath indexPathForItem:0 inSection:section]];
            attributes.frame = CGRectMake(_sectionInset.left, top, headerSize.width, headerSize.height);
            _headerAttributes[@(section)] = attributes;
            [_allAttributes addObject:attributes];
            top = CGRectGetMaxY(attributes.frame);
        }
        
        [_columnHeights addObject:[NSMutableArray array]];
        for (NSUInteger idx = 0; idx < _numberOfColumns; idx++) {
            [_columnHeights[section] addObject:@(top)];
        }
        
        CGFloat columnWidth = [self _columnWidthForSection:section];
        [_itemAttributes addObject:[NSMutableArray array]];
        for (NSUInteger idx = 0; idx < numberOfItems; idx++) {
            NSUInteger columnIndex = [self _shortestColumnIndexInSection:section];
            NSIndexPath *indexpath = [NSIndexPath indexPathForItem:idx inSection:section];
            
            CGSize itemSize = [self _itemSizeAtIndexPath:indexpath];
            CGFloat xOffset = _sectionInset.left + (columnWidth + _columnSpacing) * columnIndex;
            CGFloat yOffset = [_columnHeights[section][columnIndex] floatValue];
            
            UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes
                layoutAttributesForCellWithIndexPath:indexpath];
            attributes.frame = (CGRect){.origin = CGPointMake(xOffset, yOffset), .size = itemSize};
            
            _columnHeights[section][columnIndex] = @(CGRectGetMaxY(attributes.frame) + _interItemSpacing.bottom);
            
            [_itemAttributes[section] addObject:attributes];
            [_allAttributes addObject:attributes];
        }
        
        NSUInteger columnIndex = [self _tallestColumnIndexInSection:section];
        top = [_columnHeights[section][columnIndex] floatValue] - _interItemSpacing.bottom + _sectionInset.bottom;
        
        for (NSUInteger idx = 0; idx < [_columnHeights[section] count]; idx++) {
            _columnHeights[section][idx] = @(top);
        }
    }
}

#pragma mark - Layout Attributes
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *includedAttributes = [NSMutableArray array];
    for (UICollectionViewLayoutAttributes *attributes in _allAttributes) {
        if (CGRectIntersectsRect(attributes.frame, rect)) {
            [includedAttributes addObject:attributes];
        }
    }
    return includedAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section >= _itemAttributes.count) {
        return nil;
    } else if (indexPath.item >= [_itemAttributes[indexPath.section] count]) {
        return nil;
    }
    return _itemAttributes[indexPath.section][indexPath.item];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        return _headerAttributes[@(indexPath.section)];
    }
    return nil;
}

#pragma mark - Layout Invalid for Bounds Change
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    if (!CGSizeEqualToSize(self.collectionView.bounds.size, newBounds.size)) {
        return YES;
    }
    return NO;
}

#pragma mark - Inner Delegate Setter
- (id<FLCollectionViewLayoutDelegate>)_delegate {
    return (id<FLCollectionViewLayoutDelegate>)self.collectionView.delegate;
}

#pragma mark - Inner Calculate
- (CGFloat)_widthForSection:(NSUInteger)section {
    return self.collectionView.bounds.size.width - (_sectionInset.left + _sectionInset.right);
}

- (CGSize)_headerSizeForSection:(NSUInteger)section {
    return CGSizeMake([self _widthForSection:section], _headerHeight);
}

- (CGFloat)_columnWidthForSection:(NSUInteger)section {
    return ([self _widthForSection:section] - ((_numberOfColumns - 1) * _columnSpacing)) / _numberOfColumns;
}

- (CGSize)_itemSizeAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size = CGSizeMake([self _columnWidthForSection:indexPath.section], 0);
    CGSize originalSize = [[self _delegate] collectionView:self.collectionView layout:self originalItemSizeAtIndexPath:indexPath];
    if (originalSize.height > 0 && originalSize.width > 0) {
        size.height = originalSize.height / originalSize.width * size.width;
    }
    return size;
}

- (NSUInteger)_shortestColumnIndexInSection:(NSUInteger)section {
    __block NSUInteger index = 0;
    __block CGFloat shortestHeight = CGFLOAT_MAX;
    [_columnHeights[section] enumerateObjectsUsingBlock:^(NSNumber *heightNum, NSUInteger idx, BOOL *stop) {
        if (heightNum.floatValue < shortestHeight) {
            index = idx;
            shortestHeight = heightNum.floatValue;
        }
    }];
    
    return index;
}

- (NSUInteger)_tallestColumnIndexInSection:(NSUInteger)section {
    __block NSUInteger index = 0;
    __block CGFloat tallestHeight = 0.0;
    [_columnHeights[section] enumerateObjectsUsingBlock:^(NSNumber *heightNum, NSUInteger idx, BOOL *stop) {
        if (heightNum.floatValue > tallestHeight) {
            index = idx;
            tallestHeight = heightNum.floatValue;
        }
    }];
    
    return index;
}

#pragma mark - Override Calculate
- (CGSize)collectionViewContentSize {
    CGFloat height = [[[_columnHeights lastObject] firstObject] floatValue];
    return CGSizeMake(self.collectionView.bounds.size.width, height);
}

@end

#pragma mark -
#pragma mark - Implementation FLCollectionViewLayoutInspector 
@implementation FLCollectionViewLayoutInspector

- (ASSizeRange)collectionView:(ASCollectionView *)collectionView constrainedSizeForNodeAtIndexPath:(NSIndexPath *)indexPath {
    FLCollectionViewLayout *layout = (FLCollectionViewLayout *)[collectionView collectionViewLayout];
    return ASSizeRangeMake(CGSizeZero, [layout _itemSizeAtIndexPath:indexPath]);
}

- (ASSizeRange)collectionView:(ASCollectionView *)collectionView constrainedSizeForSupplementaryNodeOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    FLCollectionViewLayout *layout = (FLCollectionViewLayout *)[collectionView collectionViewLayout];
    return ASSizeRangeMake(CGSizeZero, [layout _headerSizeForSection:indexPath.section]);
}

- (ASScrollDirection)scrollableDirections {
    return ASScrollDirectionVerticalDirections;
}

- (NSUInteger)collectionView:(ASCollectionView *)collectionView supplementaryNodesOfKind:(NSString *)kind inSection:(NSUInteger)section {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        return 1;
    } else {
        return 0;
    }
}
@end
