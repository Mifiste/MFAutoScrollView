//
//  MFAutoScrollView.m
//  MFAutoScrollView
//
//  Created by lanouhn on 16/4/28.
//  Copyright © 2016年 Mifiste. All rights reserved.
//

#import "MFAutoScrollView.h"

/**
 *  Marco
 */
#define kFrameWidth self.frame.size.width
#define kFrameHeight self.frame.size.height

#define kSpaceValue 20

@interface MFAutoScrollView () <UIScrollViewDelegate>
/**
 *  UI
 */
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageContnrol;

/**
 *  Data
 */
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, strong) NSTimer *timer;

/**
 *  Variable
 */
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) NSTimeInterval timeInterval;

@end

@implementation MFAutoScrollView

- (NSMutableArray *)imageArray {
    if (!_imageArray) {
        self.imageArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _imageArray;
}

- (NSMutableArray *)titleArray {
    if (!_titleArray) {
        self.titleArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _titleArray;
}

- (instancetype)initWithFrame:(CGRect)frame WithImageArray:(NSMutableArray <NSString *>*)imageArray TitleArray:(NSMutableArray <NSString *>*)titleArray TimeInrerval:(NSTimeInterval)timeInterval {
    if (self = [super initWithFrame:frame]) {
        
        
        [self.imageArray addObject:imageArray.lastObject];
        [self.imageArray addObjectsFromArray:imageArray];
        [self.imageArray addObject:imageArray.firstObject];
        self.index = imageArray.count;
        self.timeInterval = timeInterval;
        
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kFrameWidth, kFrameHeight)];
        self.scrollView.contentSize = CGSizeMake(self.imageArray.count * kFrameWidth, kFrameHeight);
        self.scrollView.delegate = self;
        self.scrollView.pagingEnabled = YES;
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.contentOffset = CGPointMake(kFrameWidth, 0);
        
        
        for (int i = 0; i < self.imageArray.count; i++) {
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kFrameWidth * i, 0, kFrameWidth, kFrameHeight)];
            [imageView setImage:[UIImage imageNamed:self.imageArray[i]]];
            //            [imageView setImageWithURL:[NSURL URLWithString:imageArr[i]] placeholderImage:[UIImage imageNamed:@"ImagePlaceholder"]];
            imageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
            [imageView addGestureRecognizer:tap];
            
            if (titleArray.count != 0) {
                [self.titleArray addObject:titleArray.lastObject];
                [self.titleArray addObjectsFromArray:titleArray];
                [self.titleArray addObject:titleArray.firstObject];
                
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, kFrameHeight - 30, kFrameWidth - 100, 30)];
                label.text = self.titleArray[i];
                [imageView addSubview:label];
            }
            
            [self.scrollView addSubview:imageView];
            
        }
        
        [self addSubview:self.scrollView];
        
        self.pageContnrol = [[UIPageControl alloc] initWithFrame:CGRectMake(kFrameWidth - 100, kFrameHeight - 30, 100, 30)];
        self.pageContnrol.numberOfPages = self.index;
        
        [self addSubview:self.pageContnrol];
        
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(timeChangeAction:) userInfo:nil repeats:YES];
        
        
        self.backgroundColor = [UIColor cyanColor];
    }
    
    return self;
}

#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat number = scrollView.contentOffset.x / kFrameWidth - 1;
    self.pageContnrol.currentPage = number;
    [self changeImage];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat number = scrollView.contentOffset.x / kFrameWidth - 1;
    self.pageContnrol.currentPage = number;
    [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:self.timeInterval]];
    [self changeImage];
}

//开始进行拖拽时
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    //滚动视图将计时器暂停,防止自动滚动与拖拽产生冲突
    [self.timer setFireDate:[NSDate distantFuture]];
}

#pragma mark TimeAction
- (void)timeChangeAction:(NSTimer *)sender {
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x + kFrameWidth, 0) animated:YES];
    [self changeImage];
}

- (void)changeImage {
    if (self.scrollView.contentOffset.x == 0) {
        [self.scrollView setContentOffset:CGPointMake(kFrameWidth * self.index, 0) animated:NO];
    }
    if (self.scrollView.contentOffset.x == kFrameWidth * (self.index + 1)) {
        [self.scrollView setContentOffset:CGPointMake(kFrameWidth, 0) animated:NO];
    }
}

#pragma mark TapAction 
- (void)tapAction:(UITapGestureRecognizer *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickImageAtIndex:)]) {
        [self.delegate clickImageAtIndex:self.pageContnrol.currentPage];
    }
}
@end
