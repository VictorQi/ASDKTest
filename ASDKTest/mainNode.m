//
//  mainNode.m
//  ASDKTest
//
//  Created by v.q on 2017/1/11.
//  Copyright © 2017年 Victor Qi. All rights reserved.
//

#import "mainNode.h"
#import "FLNewRecommendedFollowingCell.h"
#import "FLNewSupplementaryNode.h"
#import "NSString+TransformNum.h"
#import "Utilities.h"
#import "FLCollectionViewLayout.h"

@interface mainNode () <ASCollectionDelegate, ASCollectionDataSource>
@property (nonatomic, strong) ASCollectionNode *collectionNode;
@property (nonatomic, strong) ASButtonNode *doneButton;
@property (nonatomic, strong) FLDiscoveryModel *model;
@property (nonatomic, strong) FLCollectionViewLayoutInspector *layoutInspector;
@property (nonatomic, strong) NSMutableArray *selectedItems;
@end

@implementation mainNode
#pragma mark - Life Cycle
- (instancetype)initWithFollowingModel:(FLDiscoveryModel *)model {
    _model = model;
    _selectedItems = [NSMutableArray arrayWithCapacity:9];
    for (NSUInteger idx = 0; idx < 9; idx++) {
        [_selectedItems addObject:model];
    }
    
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        
        FLCollectionViewLayout *customLayout = [[FLCollectionViewLayout alloc]init];
        customLayout.numberOfColumns = 3;
        customLayout.headerHeight = 48.5*ScreenHeightRatio;
        customLayout.columnSpacing = 0.0;
        customLayout.sectionInset = UIEdgeInsetsZero;
        customLayout.interItemSpacing = UIEdgeInsetsZero;
        
        _layoutInspector = [[FLCollectionViewLayoutInspector alloc]init];
        
        _collectionNode = [[ASCollectionNode alloc]initWithCollectionViewLayout:customLayout];
        [self addSubnode:_collectionNode];
        
        _collectionNode.dataSource = self;
        _collectionNode.delegate = self;
        [_collectionNode registerSupplementaryNodeOfKind:UICollectionElementKindSectionHeader];
        
        _doneButton = [[ASButtonNode alloc]init];
        [_doneButton setBackgroundImage:[UIImage imageNamed:@"done_normal"] forState:ASControlStateNormal];
        [_doneButton setBackgroundImage:[UIImage imageNamed:@"done_highlight"] forState:ASControlStateHighlighted];
        [_doneButton setTitle:@"DONE" withFont:[UIFont systemFontOfSize:10.5*ScreenHeightRatio] withColor:[UIColor whiteColor] forState:ASControlStateNormal];
        [self addSubnode:_doneButton];
    }
    
    return self;
}

#pragma mark - Did Load (In Main Thread)
- (void)didLoad {
    [super didLoad];
    self.collectionNode.allowsMultipleSelection = YES;
    self.collectionNode.view.layoutInspector = self.layoutInspector;
    
    [self.doneButton addTarget:self action:@selector(doneButtonPressed:) forControlEvents:ASControlNodeEventTouchUpInside];
}

#pragma mark - ASCollectionNode Delegate
- (void)collectionNode:(ASCollectionNode *)collectionNode didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger item = indexPath.item;
    [self.selectedItems insertObject:self.model atIndex:item];
}

- (void)collectionNode:(ASCollectionNode *)collectionNode didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger item = indexPath.item;
    [self.selectedItems removeObjectAtIndex:item];
}

#pragma mark - FLCollectionViewLayoutDelegate
- (CGSize)collectionView:(ASCollectionNode *)collectionNode layout:(UICollectionViewLayout *)collectionViewLayout originalItemSizeAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(kScreenWidth / 3.0, kScreenHeight * 15.0 / 71.0);
}

#pragma mark - ASCollectionNode Data Source
- (NSInteger)collectionNode:(ASCollectionNode *)collectionNode numberOfItemsInSection:(NSInteger)section {
    return 9;
}

- (NSInteger)numberOfSectionsInCollectionNode:(ASCollectionNode *)collectionNode {
    return 1;
}

- (ASCellNodeBlock)collectionNode:(ASCollectionNode *)collectionNode nodeBlockForItemAtIndexPath:(NSIndexPath *)indexPath {
    return ^{
        return [[FLNewRecommendedFollowingCell alloc]initWithFollowingModel:self.model];
    };
}

- (ASCellNode *)collectionNode:(ASCollectionNode *)collectionNode nodeForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    BOOL isHeaderSection = [kind isEqualToString:UICollectionElementKindSectionHeader];
    if (!isHeaderSection) { return nil; }
    NSString *text = @"None of your following is\n broadcasting.Find others who are!";
    FLNewSupplementaryNode *node = [[FLNewSupplementaryNode alloc] initWithText:text];
    
    return node;
}

#pragma mark - Layout
- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize {
    self.collectionNode.style.width = ASDimensionMakeWithFraction(1.0);
    self.collectionNode.style.height = ASDimensionMakeWithFraction(0.507);
    
    self.doneButton.style.preferredSize = CGSizeMake(0.0, 43*ScreenHeightRatio);
    
    ASInsetLayoutSpec *buttonInsetsSpec = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(0.0, 15.0*ScreenWidthRatio, 21.0*ScreenHeightRatio, 15.0*ScreenWidthRatio) child:self.doneButton];
    
    ASStackLayoutSpec *verticalStackSpec = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:33.0*ScreenHeightRatio justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStretch children:@[self.collectionNode, buttonInsetsSpec]];
    
    return verticalStackSpec;
}

#pragma mark - Done Button Pressed
- (void)doneButtonPressed:(ASButtonNode *)button {
    NSLog(@"done button clicked");
    [self.selectedItems enumerateObjectsUsingBlock:^(FLDiscoveryModel *model, NSUInteger idx, BOOL *stop) {
        NSLog(@"model.name is %@, idx is %lu", model.nick, idx);
    }];
}

@end
