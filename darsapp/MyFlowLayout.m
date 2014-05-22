//
//  MyFlowLayout.m
//  darsapp
//
//  Created by inf227al on 22/05/14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//

#import "MyFlowLayout.h"

@implementation MyFlowLayout
-(void)setCurrentCellScale:(CGFloat)scale;
{
    _currentCellScale = scale;
    [self invalidateLayout];
}

- (void)setCurrentCellCenter:(CGPoint)origin
{
    _currentCellCenter = origin;
    [self invalidateLayout];
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // Get the current attributes for the item at the indexPath
    UICollectionViewLayoutAttributes *attributes =
    [super layoutAttributesForItemAtIndexPath:indexPath];
    
    // Modify them to match the pinch values
    [self modifyLayoutAttributes:attributes];
    
    // return them to collection view
    return attributes;
}

-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
    // Get all the attributes for the elements in the specified frame
    NSArray *allAttributesInRect = [super
                                    layoutAttributesForElementsInRect:rect];
    
    for (UICollectionViewLayoutAttributes *cellAttributes in allAttributesInRect)
    {
        // Modify the attributes for the cells in the frame rect
        [self modifyLayoutAttributes:cellAttributes];
    }
    return allAttributesInRect;
}

-(void)modifyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    // If the indexPath matches the one we have stored
    if ([layoutAttributes.indexPath isEqual:_currentCellPath])
    {
        // Assign the new layout attributes
        layoutAttributes.transform3D =
        CATransform3DMakeScale(_currentCellScale, _currentCellScale, 1.0);
        layoutAttributes.center = _currentCellCenter;
        layoutAttributes.zIndex = 1;
    }
}
@end
