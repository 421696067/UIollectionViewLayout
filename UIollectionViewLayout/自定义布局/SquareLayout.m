//
//  SquareLayout.m
//  01-百思不得其姐
//
//  Created by 李攀祥 on 16/3/8.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import "SquareLayout.h"

@implementation SquareLayout
-(void)prepareLayout
{
    [super prepareLayout];
}

/**
 * UICollectionViewLayoutAttributes * lastAttrs = mArr[i-6];
 CGRect  frame = lastAttrs.frame;
 frame.origin.y += 2 * width;
 lastAttrs.frame=frame;
 [mArr addObject:lastAttrs];

 */
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray * mArr= [NSMutableArray  array];
    NSInteger count =[self.collectionView   numberOfItemsInSection:0];
    CGFloat width =self.collectionView.frame.size.width*0.5;
//    CGFloat height =width;
    for (int i=0; i<count; i++) {
        NSIndexPath *  indexPath =[NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes * attrs=[UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
//
//        CGFloat row = (i+3-1)/3;
//        if (i==0) {
//            attrs.frame = CGRectMake(0, 0, width, height);
//        }else if (i==1){
//            attrs.frame = CGRectMake(width, 0, width, height/2);
//        }else if (i==2){
//            attrs.frame = CGRectMake(width, height/2, width, height/2);
//        }else if (i==3){
//            attrs.frame = CGRectMake(0, height, width, height/2);
//        }else if (i==4){
//            attrs.frame = CGRectMake(0, height+height/2, width, height/2);
//        }else if (i==5){
//            attrs.frame = CGRectMake(width, height, width, height);
//        }else{
//           UICollectionViewLayoutAttributes *lastAttrs = mArr[i-6];
//            CGRect frame  = lastAttrs.frame;
//            frame.origin.y+=2 * height;
//            attrs.frame=frame;
//        }
        if ((i+1)%6==1|(i+1)%6==0) {
            int k;
            //TODO:floor()这个是向上取整
            if ((i+1)%6==1) {
               k = floor((i+1)/6+1)*2-2;
            }else{
               k = floor((i+1)/6)*2-1;
            }
            CGFloat height = width;
            CGFloat x = (i+1)%6==0 ?width:0;
            attrs.frame = CGRectMake(x,k*height , width,height);
//            NSLog(@"%d",k);
        }else{
            int j;
            if ((i+1)%6==2) {
                j = floor((i+1)/6+1)*4-4;
            }else if((i+1)%6==3){
                j = floor((i+1)/6+1)*4-3;
            }else if ((i+1)%6==4){
                j = floor((i+1)/6+1)*4-2;
            }else{
                j = floor((i+1)/6+1)*4-1;
            }
            CGFloat height = width/2;
            CGFloat x = (i+1)%6==3|(i+1)%6==2?width:0;
            attrs.frame = CGRectMake(x, j*height, width, height);
            NSLog(@"%d---%d",j,(int)x);
        }
        [mArr addObject:attrs];
    }
    return mArr;
}

#pragma mark ---- 返回CollectionView的内容大小
/*!
 * 如果不设置这个的话  CollectionView就不能滑动
 */
-(CGSize)collectionViewContentSize
{
    int count =(int)[self.collectionView numberOfItemsInSection:0];
    int rows=(count +3 -1)/3;
    CGFloat rowH = self.collectionView.frame.size.width/2;
        if ((count)%6==2|(count)%6==4) {
            return CGSizeMake(0, rows * rowH-rowH/2);
        }else{
            return CGSizeMake(0, rows*rowH);
        }
}



-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width =self.collectionView.frame.size.width*0.5;
        UICollectionViewLayoutAttributes * attrs=[UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        NSInteger i=indexPath.item;
        if ((i+1)%6==1|(i+1)%6==0) {
            int k;
            //TODO:floor()这个是向上取整
            if ((i+1)%6==1) {
                k = floor((i+1)/6+1)*2-2;
            }else{
                k = floor((i+1)/6)*2-1;
            }
            CGFloat height = width;
            CGFloat x = (i+1)%6==0 ?width:0;
            attrs.frame = CGRectMake(x,k*height , width,height);
        }else{
            int j;
            if ((i+1)%6==2) {
                j = floor((i+1)/6+1)*4-4;
            }else if((i+1)%6==3){
                j = floor((i+1)/6+1)*4-3;
            }else if ((i+1)%6==4){
                j = floor((i+1)/6+1)*4-2;
            }else{
                j = floor((i+1)/6+1)*4-1;
            }
            CGFloat height = width/2;
            CGFloat x = (i+1)%6==3|(i+1)%6==2?width:0;
            attrs.frame = CGRectMake(x, j*height, width, height);
        }
   return attrs;
}

@end
