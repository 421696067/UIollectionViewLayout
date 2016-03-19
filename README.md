###首先我们先看一下 我们今天要最终实现的效果图


***
###UICollectionView的简单介绍###
* UICollectionView的结构
```
Cells
Supplementary Views 追加视图 （类似Header或者Footer）
Decoration Views 装饰视图 （用作背景展示）
```
* 由两个方面对UICollectionView进行支持。
*  和tableView一样，即提供数据的UICollectionViewDataSource以及处理用户交互的UICollectionViewDelegate。
* 另一方面，对于cell的样式和组织方式，由于collectionView比tableView要复杂得多，因此没有按照类似于tableView的style的方式来定义，而是专门使用了一个类来对collectionView的布局和行为进行描述，这就是`UICollectionViewLayout`。

* 而我们主要讲UICollectionViewLayout，因为这不仅是collectionView和tableView的最重要求的区别，也是整个UICollectionView的精髓所在。
* 如果对UICollectionView的基本构成要素和使用方法还不清楚的话，可以查看：[UICollectionView详解](http://www.onevcat.com/2012/06/introducing-collection-views/)中进行一些了解。

***
*
### UICollectionViewLayoutAttributes类的介绍###
```
@property (nonatomic) CGRect frame
@property (nonatomic) CGPoint center
@property (nonatomic) CGSize size
@property (nonatomic) CATransform3D transform3D
@property (nonatomic) CGFloat alpha
@property (nonatomic) NSInteger zIndex
@property (nonatomic, getter=isHidden) BOOL hidden
```
>可以看到，UICollectionViewLayoutAttributes的实例中包含了诸如边框，中心点，大小，形状，透明度，层次关系和是否隐藏等信息。
1.一个cell对应一个UICollectionViewLayoutAttributes对象
2.UICollectionViewLayoutAttributes对象决定了cell的摆设位置（frame）

###自定义的UICollectionViewLayout
* UICollectionViewLayout的功能为向UICollectionView提供布局信息，不仅包括cell的布局信息，也包括追加视图和装饰视图的布局信息。实现一个自定义layout的常规做法是继承UICollectionViewLayout类，然后重载下列方法：

```
-(void)prepareLayout
准备方法被自动调用，以保证layout实例的正确。

-(CGSize)collectionViewContentSize
返回collectionView的内容的尺寸

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
1.返回rect中的所有的元素的布局属性
2.返回的是包含UICollectionViewLayoutAttributes的NSArray
3.UICollectionViewLayoutAttributes可以是cell，追加视图或装饰视图的信息，通过不同的UICollectionViewLayoutAttributes初始化方法可以得到不同类型的UICollectionViewLayoutAttributes：
1)layoutAttributesForCellWithIndexPath:
2)layoutAttributesForSupplementaryViewOfKind:withIndexPath:
3)layoutAttributesForDecorationViewOfKind:withIndexPath:

-(UICollectionViewLayoutAttributes )layoutAttributesForItemAtIndexPath:(NSIndexPath )indexPath
返回对应于indexPath的位置的cell的布局属性

-(UICollectionViewLayoutAttributes )layoutAttributesForSupplementaryViewOfKind:(NSString )kind atIndexPath:(NSIndexPath *)indexPath
返回对应于indexPath的位置的追加视图的布局属性，如果没有追加视图可不重载

-(UICollectionViewLayoutAttributes * )layoutAttributesForDecorationViewOfKind:(NSString)decorationViewKind atIndexPath:(NSIndexPath )indexPath
返回对应于indexPath的位置的装饰视图的布局属性，如果没有装饰视图可不重载

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
当边界发生改变时，是否应该刷新布局。如果YES则在边界变化（一般是scroll到其他地方）时，将重新计算需要的布局信息。
```
* 调用顺序

```
1）-(void)prepareLayout  设置layout的结构和初始需要的参数等。

2)  -(CGSize) collectionViewContentSize 确定collectionView的所有内容的尺寸。

3）-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect初始的layout的外观将由该方法返回的UICollectionViewLayoutAttributes来决定。

4)在需要更新layout时，需要给当前layout发送 
1)-invalidateLayout， 该消息会立即返回，并且预约在下一个loop的时候刷新当前layout
2)-prepareLayout，
3)依次再调用-collectionViewContentSize和-layoutAttributesForElementsInRect来生成更新后的布局。
```

[LineLayout](http://www.jianshu.com/p/a16ffb4bbcc2)：**流水布局实例**http://www.jianshu.com/p/a16ffb4bbcc2
![流水布局](http://upload-images.jianshu.io/upload_images/1418424-2d1ced7aba5fae41.gif?imageMogr2/auto-orient/strip)
***
[圆形布局CircleLayout](http://www.jianshu.com/p/83e31a2f18d9) http://www.jianshu.com/p/83e31a2f18d9
![圆形布局](http://upload-images.jianshu.io/upload_images/1418424-5c7d83b061a53437.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
***
[方行布局](http://www.jianshu.com/p/58e06e1f2f6d)http://www.jianshu.com/p/58e06e1f2f6d 
![SquareLayout](http://upload-images.jianshu.io/upload_images/1418424-a790ec383a44c5e9.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)