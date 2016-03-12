//
//  ViewController.m
//  UIollectionViewLayout
//
//  Created by 李攀祥 on 16/3/12.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import "ViewController.h"
#import "PhotoCell.h"

#import "CustomFlowLayout.h"
#import "CircleLayout.h"
#import "SquareLayout.h"
@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView * myCollectionView;
/** 数据源 */
@property (nonatomic,strong)NSMutableArray * dataArr;
/** CollectionView的自带的流水布局 */
@property (nonatomic,strong)UICollectionViewFlowLayout * defauleLayout;
/** 自定义的CollectionView的流水布局 */
@property (nonatomic,strong)CustomFlowLayout * layout;
/** 自定义的圆形布局 */
@property (nonatomic,strong)CircleLayout* cirLayout;
/** 自定义方形布局 */
@property (nonatomic,strong)SquareLayout * squareLayout;
@end

static NSString * const PhotoCellId = @"photo";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.myCollectionView];
    [self  addChangedBtn];
}
#pragma mark ---- 添加 改变布局的按钮
-(void)addChangedBtn
{
    //1.创建btn
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    //btn.center=CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height-80);
    btn.frame=CGRectMake(200,300, 80, 80);
    // 2.设置按钮的图片
    [btn setBackgroundImage:[UIImage  imageNamed:@"sub_add"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"sub_add_h"] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(changedLayout) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
#pragma mark ---- 切换布局
-(void)changedLayout
{
    if ([self.myCollectionView.collectionViewLayout isKindOfClass:[CircleLayout class]]){
        [self.myCollectionView setCollectionViewLayout:self.layout animated:YES];
    }else if([self.myCollectionView.collectionViewLayout isKindOfClass:[CustomFlowLayout class]]){
        [self.myCollectionView setCollectionViewLayout:self.squareLayout animated:YES];
    }else if([self.myCollectionView.collectionViewLayout isKindOfClass:[SquareLayout class]]){
        [self.myCollectionView setCollectionViewLayout:self.defauleLayout animated:YES];
    }else{
        [self.myCollectionView setCollectionViewLayout:self.cirLayout animated:YES];
    }
}

#pragma mark- 懒加载
-(NSMutableArray *)dataArr
{
    if(!_dataArr){
        _dataArr=[[NSMutableArray alloc] init];
        for (int i=0; i<16; i++) {
            [_dataArr addObject:[NSString stringWithFormat:@"%d",i+1]];
        }
    }
    return _dataArr;
}

-(UICollectionView *)myCollectionView
{
    if(!_myCollectionView){
        /**
         注意：初始化collectionView 通过frame和layout 一定要传进去一个layout
         */
        _myCollectionView=[[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.layout];
        _myCollectionView.delegate = self;
        _myCollectionView.dataSource = self;
        _myCollectionView.showsVerticalScrollIndicator=NO;
        _myCollectionView.showsHorizontalScrollIndicator=NO;
        //注册cell
        [_myCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([PhotoCell class]) bundle:nil] forCellWithReuseIdentifier:PhotoCellId];
    }
    return _myCollectionView;
}

-(CustomFlowLayout *)layout
{
    if(!_layout){
        _layout=[[CustomFlowLayout alloc] init];
        _layout.itemSize=CGSizeMake(150, 150);
    }
    return _layout;
}

-(CircleLayout *)cirLayout
{
    if(!_cirLayout){
        _cirLayout=[[CircleLayout alloc] init];
    }
    return _cirLayout;
}

-(SquareLayout *)squareLayout
{
    if(!_squareLayout){
        _squareLayout=[[SquareLayout alloc] init];
    }
    return _squareLayout;
}
//这里是系统自带的流水布局
-(UICollectionViewFlowLayout *)defauleLayout
{
    /**
     UICollectionViewFlowLayout：是系统自带的唯一的布局 流水布局
     如果我们要自定义布局的话有2中方式
     1--》继承于UICollectionViewLayout(比较底层不是流水布局 没有itemSize,scrollDirection等属性)
     2--》继承于UICollectionViewFlowLayout(这个是继承与上一个的有scrollDirection等属性)
     */
    if(!_defauleLayout){
        _defauleLayout=[[UICollectionViewFlowLayout alloc] init];
        _defauleLayout.itemSize=CGSizeMake(150, 130);
        _defauleLayout.scrollDirection = UICollectionViewScrollDirectionVertical;//这2个都是流水布局的属性UICollectionViewFlowLayout
    }
    return _defauleLayout;
}

#pragma mark - CollectionView的Delegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PhotoCellId forIndexPath:indexPath];
    cell.imageName = self.dataArr[indexPath.item];
    return cell;
}

#pragma mark ----  点击item的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.dataArr removeObjectAtIndex:indexPath.item];
    //TODO:  这个方法 特别注意 删除item的方法
    [self.myCollectionView deleteItemsAtIndexPaths:@[indexPath]];
    NSLog(@"点击了 %zd" ,indexPath.item);
}
@end
