//
//  CustomCollectionViewLayout.m
//  TravelokaApp
//
//  Created by Aloysius Michael Tansy on 12/19/16.
//  Copyright © 2016 Aloysius Michael Tansy. All rights reserved.
//

#import "CustomCollectionViewLayout.h"

@interface CustomCollectionViewLayout()
@property (strong, nonatomic) NSMutableArray *itemAttributes;
@property (strong, nonatomic) NSMutableArray *itemsSize;
@property (nonatomic, assign) CGSize contentSize;

@property (nonatomic) NSInteger numberColumn;
@property (nonatomic) NSInteger numberRow;

@property (strong,nonatomic) NSMutableDictionary *layoutInfo;
@property (nonatomic) CGFloat yPosition;
@end

@implementation CustomCollectionViewLayout

- (void)prepareLayout{
    NSMutableDictionary *newLayoutInfo = [NSMutableDictionary dictionary];
    NSMutableDictionary *cellLayoutInfo = [NSMutableDictionary dictionary];
    
    NSInteger sectionCount = [self.collectionView numberOfSections];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    
    for (NSInteger section = 0; section < sectionCount; section++) {
        NSInteger itemCount = [self.collectionView numberOfItemsInSection:section];
        
        for (NSInteger item = 0; item < itemCount; item++) {
            indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            
            UICollectionViewLayoutAttributes *itemAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            itemAttributes.frame = [self frameForItemAtIndexPath:indexPath];
            
            [cellLayoutInfo setObject:itemAttributes forKey:indexPath];
        }
    }
    
//    [newLayoutInfo setObject:cellLayoutInfo forKey:MonthlyCalendarCollectionLayoutItemKey];
    [newLayoutInfo setObject:cellLayoutInfo forKey:@"month"];
    
    self.layoutInfo = newLayoutInfo;
}

- (CGRect)frameForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat cellSize = CGRectGetWidth([UIScreen mainScreen].bounds)/7;
    NSLog(@"section:%ld, row:%ld, item:%ld",indexPath.section,indexPath.row,indexPath.item);
    CGFloat x = 0.0f;
    NSInteger modulo = indexPath.item % 7;
    if(modulo<7){
        x = (modulo * cellSize) + (self.collectionView.frame.size.width * indexPath.section);
    }
    
    if(indexPath.item<7){
        _yPosition = 0.0f;
    }else if(indexPath.item%7==0){
        _yPosition += cellSize;
    }
    
    NSLog(@"indexPath.item : %ld", indexPath.item);
    CGRect cellFrame = CGRectMake(x,
        _yPosition,
        cellSize,
        cellSize);
    return cellFrame;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *allAttributes = [NSMutableArray arrayWithCapacity:self.layoutInfo.count];
    
    [self.layoutInfo enumerateKeysAndObjectsUsingBlock:^(NSString *elementIdentifier, NSDictionary *elementsInfo, BOOL *stop) {
        [elementsInfo enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *indexPath, UICollectionViewLayoutAttributes *attributes, BOOL *innerStop) {
            if (CGRectIntersectsRect(rect, attributes.frame)) {
                [allAttributes addObject:attributes];
            }
        }];
    }];
    
    return allAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
//    return [[self.layoutInfo objectForKey:MonthlyCalendarCollectionLayoutItemKey] objectForKey:indexPath];
    return [[self.layoutInfo objectForKey:@"month"] objectForKey:indexPath];
}

//- (void)prepareLayout{
//    [super prepareLayout];
////    CGFloat cellSize = CGRectGetWidth([UIScreen mainScreen].bounds)/7;
////    
////    NSInteger sectionCount = [self.collectionView numberOfSections];
////    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
////    
////    for(NSInteger section=0;section<sectionCount;section++){
////        NSInteger itemCount = [self.collectionView numberOfItemsInSection:section];
////        
////        for(NSInteger item=0;item<itemCount;item++){
////            indexPath = [NSIndexPath indexPathForItem:item inSection:section];
////            
////            
////        }
////        
////    }
//    
//    for(NSInteger i=0;i<[self.collectionView numberOfSections];i++){
//        _numberColumn = 7;
//        _numberRow = [self.collectionView numberOfItemsInSection:i]/7;
//    }
//    
//    
//}
//
- (CGSize)collectionViewContentSize{
    return CGSizeMake(self.collectionView.frame.size.width*[self.collectionView numberOfSections], self.collectionView.frame.size.height);
}
//
//- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
//    NSMutableArray* elementsInRect = [NSMutableArray array];
//    CGFloat cellSize = CGRectGetWidth([UIScreen mainScreen].bounds)/7;
//    
//    //iterate over all cells in this collection
//    for(NSUInteger i = 0; i < [self.collectionView numberOfSections]; i++)
//    {
//        NSInteger column = 7;
//        NSInteger rows = [self.collectionView numberOfItemsInSection:i]/column;
////        NSLog(@"rows : %ld",rows);
//        for(NSInteger row=0;row < rows;row++){
//            for(NSInteger col=0;col<column;col++){
//                CGRect cellFrame = CGRectMake(col*cellSize, row*cellSize, cellSize, cellSize);
//                
//                if(CGRectIntersectsRect(cellFrame, rect))
//                {
//                    //create the attributes object
//                    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:col inSection:row];
//                    UICollectionViewLayoutAttributes* attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
//                    
//                    //set the frame for this attributes object
//                    attr.frame = cellFrame;
//                    [elementsInRect addObject:attr];
//                }
//
//            }
//        }
//        
////        for(NSUInteger j = 0; j < [self.collectionView numberOfItemsInSection:i]; j++)
////        {
//////            NSLog(@"numberofItemsInSection : %ld", [self.collectionView numberOfItemsInSection:i]);
//////            if(column==0){
//////                column++;
//////            }
//////            else if(column<7){
//////                lastXPosition += cellSize;
//////                column++;
//////            }else{
//////                lastXPosition = 0.0f + (CGRectGetWidth([UIScreen mainScreen].bounds) * i);
//////                column = 0;
//////                
//////                lastYPosition += cellSize;
//////            }
////            
////            
////            
////            CGRect cellFrame = CGRectMake(lastXPosition,
////                                   lastYPosition,
////                                   cellSize,
////                                   cellSize);
////            
//////            CGRect cellFrame = CGRectMake(0.0f+(cellSize*j), 0.0f, cellSize, cellSize);
////            
////            //see if the collection view needs this cell
////            if(CGRectIntersectsRect(cellFrame, rect))
////            {
////                //create the attributes object
////                NSIndexPath* indexPath = [NSIndexPath indexPathForRow:j inSection:i];
////                UICollectionViewLayoutAttributes* attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
////                
////                //set the frame for this attributes object
////                attr.frame = cellFrame;
////                [elementsInRect addObject:attr];
////            }
////        }
////        lastYPosition = 0.0f;
////        column = 0;
////        lastXPosition += cellSize;
//    }
//    
//    return elementsInRect;
//}
//
//- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
//    UICollectionViewLayoutAttributes* attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
//    
////    CGRect cellFrame = CGRectMake(0.0f,
////                                  0.0f,
////                                  100.0f,
////                                  100.0f);
////    attributes.frame = cellFrame;
//    
//    attributes.size = CGSizeMake(100.0f, 100.0f);
//    
//    return attributes;
//}

@end
