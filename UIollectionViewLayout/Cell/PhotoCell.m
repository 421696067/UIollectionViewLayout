//
//  PhotoCell.m
//  UIollectionViewLayout
//
//  Created by 李攀祥 on 16/3/12.
//  Copyright © 2016年 李攀祥. All rights reserved.
//

#import "PhotoCell.h"

@interface PhotoCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation PhotoCell
- (void)awakeFromNib {
    self.imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.imageView.layer.borderWidth = 10;
}

- (void)setImageName:(NSString *)imageName
{
    _imageName = [imageName copy];
    
    self.imageView.image = [UIImage imageNamed:imageName];
}
@end
