//
//  TDBannerView.h
//  TDBannerCycle
//
//  Created by 卢腾达 on 2017/6/2.
//  Copyright © 2017年 卢腾达. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDBannerCollectionViewCell.h"


@interface TDBannerView : UIView

+ (instancetype)bannerWithForm:(CGRect)from iamgeURLStringGroup:(NSArray *)Group;
///是否循环播放
@property (nonatomic, assign) BOOL isLoop;
///是否自动播放
@property (nonatomic, assign) BOOL isAoto;

@property (nonatomic, assign) NSTimeInterval timeInerval;
@end
