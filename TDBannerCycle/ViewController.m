//
//  ViewController.m
//  TDBannerCycle
//
//  Created by 卢腾达 on 2017/6/2.
//  Copyright © 2017年 卢腾达. All rights reserved.
//

#import "ViewController.h"
#import "TDBannerView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor grayColor];
    
    NSArray *imageArray = @[
                            @"http://imgsrc.baidu.com/imgad/pic/item/caef76094b36acaf0accebde76d98d1001e99ce7.jpg",
                            @"http://pic.58pic.com/58pic/12/03/18/68w58PICjJP.jpg",
                            @"http://pic35.nipic.com/20131121/2531170_145358633000_2.jpg",
                            @"http://dl.bizhi.sogou.com/images/2012/04/04/294895.jpg"
                            ];
    
    
    TDBannerView *banner = [TDBannerView bannerWithForm:CGRectMake(0, 20, self.view.TDWidth, 200) iamgeURLStringGroup:imageArray];
    
    
    
    [self.view addSubview:banner];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
