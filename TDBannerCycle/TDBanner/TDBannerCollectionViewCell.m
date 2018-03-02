//
//  TDBannerCollectionViewCell.m
//  TDBannerCycle
//
//  Created by 卢腾达 on 2017/6/2.
//  Copyright © 2017年 卢腾达. All rights reserved.
//

#import "TDBannerCollectionViewCell.h"


@implementation TDBannerCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5;
        
        
        
        
        [self addSubview:self.imageView];
    }
    return self;
}

- (void)setImage:(UIImage *)image{
    _image = image;
    
    self.imageView.image = image;
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.TDWidth, self.TDHeight)];
    }
    return _imageView;
}
@end
