//
//  TDBannerView.m
//  TDBannerCycle
//
//  Created by 卢腾达 on 2017/6/2.
//  Copyright © 2017年 卢腾达. All rights reserved.
//

#import "TDBannerView.h"
#import "UIImageView+WebCache.h"


NSString *const cellID =  @"bannerCell";

@interface TDBannerView() <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, weak) UICollectionView *bannerView;
@property (nonatomic, strong) NSArray *bannerDataArray;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, assign) NSUInteger itemCount;

@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation TDBannerView


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.bannerView];
        [self addSubview:self.pageControl];
        _timeInerval = 2;
        self.isAoto = YES;
        self.isLoop = YES;
    }
    return self;
}

+ (instancetype)bannerWithForm:(CGRect)from iamgeURLStringGroup:(NSArray *)Group{
    TDBannerView *bannerview = [[self alloc]initWithFrame:from];
    bannerview.bannerDataArray = [NSMutableArray arrayWithArray:Group];
    return bannerview;
}
#pragma mark - set
- (void)setIsLoop:(BOOL)isLoop{
    _isLoop = isLoop;
    if (self.bannerDataArray.count) {
        self.bannerDataArray = self.bannerDataArray;
    }
}
- (void)setBannerDataArray:(NSArray *)bannerDataArray{
    
//    [self invalidateTimer];
    _bannerDataArray  = bannerDataArray;
    
    
    if (self.isLoop) {
        _itemCount = self.bannerDataArray.count *100;
    }else{
        _itemCount = self.bannerDataArray.count;
    }
    
    if (self.bannerDataArray.count == 1) {
        self.bannerView.scrollEnabled = NO;
        [self setIsAoto:self.isAoto];
    }else{
        self.bannerView.scrollEnabled = YES;
    }
    
    [self.bannerView reloadData];
    
}
- (void)setIsAoto:(BOOL)isAoto{
    _isAoto = isAoto;
    [self invalidateTimer];
    if (_isAoto) {
        [self setupTimer];
    }
}

#pragma mark - 开始
- (void)invalidateTimer{
    
    [_timer invalidate];
    _timer = nil;
    
}

- (void)setupTimer{
    NSTimer *timer = [NSTimer timerWithTimeInterval:self.timeInerval target:self selector:@selector(aotoScrell) userInfo:nil repeats:YES];
    _timer = timer;
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)aotoScrell{
    if (self.itemCount == 0) {
        return;
    }
    
    [self changePageCurrent];
    
    int currentIndex = [self currentIndex];
    int nextIndex = currentIndex+1;
    [self scrollToIndex:nextIndex];
    
    
}

- (int)pageControlIndexWithCurrentCellIndex:(NSInteger)index{
    return (int)index % self.bannerDataArray.count;
}
- (void)changePageCurrent{
    int current = [self pageControlIndexWithCurrentCellIndex:[self currentIndex]];
    self.pageControl.currentPage = current;
}
- (void)scrollToIndex:(int)nextIndex{
    if (nextIndex >= _itemCount) {
        if (self.isLoop) {
            nextIndex = _itemCount*0.5;
            [_bannerView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:nextIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
        }
        return;
    }
    [_bannerView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:nextIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}

- (int)currentIndex{
    int index = 0;
    if (self.flowLayout.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        index = (self.bannerView.contentOffset.x +self.flowLayout.itemSize.width  *0.5) / self.flowLayout.itemSize.width;
    }else{
        index = (self.bannerView.contentOffset.y +self.flowLayout.itemSize.height  *0.5) / self.flowLayout.itemSize.height;
    }
    
    return MAX(0, index);
}


#pragma mark - collectionDataSouce


- (NSInteger )collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.itemCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TDBannerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    NSInteger index = [self pageControlIndexWithCurrentCellIndex:indexPath.item];
    
    NSString *imageString = self.bannerDataArray[index];
    if ([imageString hasPrefix:@"http"]) {
        UIImage *palceImage = [UIImage imageNamed:@"place"];
        NSURL *imageURL = [NSURL URLWithString:imageString];
        [cell.imageView sd_setImageWithURL:imageURL placeholderImage:palceImage];
        
    }
    
    return cell;
    
}
- (void)layoutSubviews{
    
    if (_bannerView.contentOffset.x == 0 &&  _itemCount) {
        int targetIndex = 0;
        if (self.isLoop) {
            targetIndex = _itemCount * 0.5;
        }else{
            targetIndex = 0;
        }
        [_bannerView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    
    int width = (int)self.bannerDataArray.count *10;
    
    self.pageControl.frame = CGRectMake(30, self.TDHeight -20, width, 10);
    self.pageControl.numberOfPages = self.bannerDataArray.count;
//    self.pageControl.currentPage = 1;
}
#pragma mark - UIScrollViewDelegate


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (!self.bannerDataArray.count) return;
    int itemIndex = [self currentIndex];
    int indexOnPageControl = [self pageControlIndexWithCurrentCellIndex:itemIndex];
    

    UIPageControl *pageControl = (UIPageControl *)_pageControl;
    pageControl.currentPage = indexOnPageControl;

}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (self.isLoop) {
        [self invalidateTimer];
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (self.isLoop) {
        [self setupTimer];
    }
}


    

#pragma mark - 懒加载
- (UICollectionView *)bannerView{
    if (!_bannerView) {
        UICollectionView *collection = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:self.flowLayout];
        collection.backgroundColor = [UIColor clearColor];
        collection.pagingEnabled = YES;
        collection.showsVerticalScrollIndicator = NO;
        collection.showsHorizontalScrollIndicator = NO;
        [collection registerClass:[TDBannerCollectionViewCell class] forCellWithReuseIdentifier:cellID];
        collection.delegate = self;
        collection.dataSource = self;
        _bannerView = collection;
        
        
    }
    return _bannerView;
}


- (UICollectionViewFlowLayout *)flowLayout{
    if (!_flowLayout) {
         _flowLayout = [[UICollectionViewFlowLayout alloc]init];
//        _flowLayout.headerReferenceSize = CGSizeMake(self.TDWidth, self.TDHeight);
        _flowLayout.minimumLineSpacing = 0;
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _flowLayout.itemSize = CGSizeMake(self.TDWidth, self.TDHeight);
    }
    return _flowLayout;
}

- (UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [UIPageControl new];
    }
    return _pageControl;
}

@end
