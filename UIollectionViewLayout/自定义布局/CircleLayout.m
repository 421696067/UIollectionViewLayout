//
//  CircleLayout.m
//  01-百思不得其姐
//
//  Created by 李攀祥 on 16/3/8.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import "CircleLayout.h"
@interface CircleLayout ()
@property(nonatomic,strong)NSMutableArray * attrsArr;
@end

@implementation CircleLayout
-(NSMutableArray *)attrsArr
{
    if(!_attrsArr){
        _attrsArr=[[NSMutableArray alloc] init];
    }
    return _attrsArr;
}

-(void)prepareLayout
{
    [super prepareLayout];
    [self.attrsArr removeAllObjects];
    [self creatAttrs];
}
-(void)creatAttrs{
    //CollectionView的圆心的位置
    CGFloat Ox = self.collectionView.frame.size.width/2;
    CGFloat Oy = self.collectionView.frame.size.height/2;
    //计算出每组有多少个
    NSInteger  count=[self.collectionView numberOfItemsInSection:0];
    //最小的角度
    CGFloat angle = 2* M_PI /count ;
    //设置半径
    CGFloat radius=70;
    /**
     * 因为不是继承流水布局 UICollectionViewFlowLayout
     * 所以我们需要自己创建 UICollectionViewLayoutAttributes
     */
    //如果是多组的话  需要2层循环
    for (int i=0; i<count; i++) {
        //创建UICollectionViewLayoutAttributes
        NSIndexPath * indexPath = [NSIndexPath indexPathForItem:i inSection:0   ];
        //这里需要 告诉 UICollectionViewLayoutAttributes 是哪里的attrs
        UICollectionViewLayoutAttributes * attrs=[UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attrs.center =  CGPointMake(Ox+radius*sin(angle*i), Oy+radius*cos(angle*i));
        attrs.size=CGSizeMake(50, 50);
        [self.attrsArr addObject:attrs];
    }
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    //TODO:  特别注意 在这个方法里 可以边滑动边刷新（添加） attrs 一劳永逸 如果只需要添加一次的话  可以把这些 prepareLayout方法中去
    return self.attrsArr;
}

#pragma mark ---- 这个方法需要返回indexPath位置对应cell的布局属性
/**
 *  //TODO:  这个方法主要用于 切换布局的时候 如果不适用该方法 就不会切换布局的时候会报错
 *   reason: 'no UICollectionViewLayoutAttributes instance for -layoutAttributesForItemAtIndexPath: <NSIndexPath: 0xc000000000400016> {length = 2, path = 0 - 2}'
 */

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
   //TODO: 主要是返回每个indexPath的attrs

    //创建UICollectionViewLayoutAttributes
    //这里需要 告诉 UICollectionViewLayoutAttributes 是哪里的attrs
    //计算出每组有多少个
    NSInteger  count=[self.collectionView numberOfItemsInSection:0];
    //角度
    CGFloat angle = 2* M_PI /count *indexPath.item;
    //设置半径
    CGFloat radius=70;
    //CollectionView的圆心的位置
    CGFloat Ox = self.collectionView.frame.size.width/2;
    CGFloat Oy = self.collectionView.frame.size.height/2;
    UICollectionViewLayoutAttributes * attrs=[UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attrs.center =  CGPointMake(Ox+radius*sin(angle), Oy+radius*cos(angle));
    attrs.size=CGSizeMake(50, 50);
    return attrs;
}

@end
