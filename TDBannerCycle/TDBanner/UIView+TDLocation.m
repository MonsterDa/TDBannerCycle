//
//  UIView+TDLocation.m
//  TDBannerCycle
//
//  Created by 卢腾达 on 2017/6/2.
//  Copyright © 2017年 卢腾达. All rights reserved.
//

#import "UIView+TDLocation.h"

@implementation UIView (TDLocation)
- (CGFloat)TDHeight{
    return self.frame.size.height;
}

- (void)setTDHeight:(CGFloat)TDHeight{
    CGRect temp = self.frame;
    temp.size.height = TDHeight;
    self.frame = temp;
}

- (CGFloat)TDWidth{
    return self.frame.size.width;
}

- (void)setTDWidth:(CGFloat)TDWidth{
    CGRect temp = self.frame;
    temp.size.width = TDWidth;
    self.frame = temp;
}

- (CGFloat)TDX{
    return self.frame.origin.x;
}

- (void)setTDX:(CGFloat)TDX{
    CGRect temp = self.frame;
    temp.origin.x = TDX;
    self.frame = temp;
}

- (CGFloat)TDY{
    return self.frame.origin.y;
}

- (void)setTDY:(CGFloat)TDY{
    CGRect temp = self.frame;
    temp.origin.y = TDY;
    self.frame = temp;
}

@end
