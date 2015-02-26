//
//  ViewController.m
//  LunBoTu
//
//  Created by Mac on 15/2/26.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "ViewController.h"
#import "InfoViewController.h"

@interface ViewController ()<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    UIPageControl *pageControl;
    NSTimer *timer;
}
@end
#define kScreenWidth  [[UIScreen mainScreen]bounds].size.width

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //解决scrolllView下移64
    //是否与navigationBar的起点重合
    self.navigationController.navigationBar.translucent = NO;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 70, kScreenWidth, 260)];
    [_scrollView setBackgroundColor:[UIColor orangeColor]];
    [_scrollView setPagingEnabled:YES];
    [_scrollView setContentSize:CGSizeMake(320*3, 260)];
    [_scrollView setShowsVerticalScrollIndicator:NO];
    [_scrollView setShowsHorizontalScrollIndicator:NO];
    [_scrollView setDelegate:self];
    [self.view addSubview:_scrollView];
    
    pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 230, kScreenWidth, 30)];
    pageControl.currentPage = 0;
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.numberOfPages = 3;
    [self.view addSubview:pageControl];
    
    for (int i=0; i<3; i++) {
        UIButton *imageBtn = [[UIButton alloc] initWithFrame:CGRectMake(i*kScreenWidth, 0, kScreenWidth, 260)];
        [imageBtn setBackgroundColor:[UIColor redColor]];
        [_scrollView addSubview:imageBtn];
    }
    
    for (int i = 0; i < 3; i++)
    {
        UIButton *imageBtn = [[UIButton alloc] initWithFrame:CGRectMake(i*kScreenWidth, 0, kScreenWidth, 260)];
        [imageBtn setTag:i+100];
        [imageBtn setBackgroundColor:[UIColor greenColor]];
        [imageBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"ad_%d",i+1]] forState:UIControlStateNormal];
        [imageBtn setContentMode:UIViewContentModeScaleToFill];
        [imageBtn addTarget:self action:@selector(openADWidthTag:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:imageBtn];
    }
    [self addTimer];
    
}


-(void)addTimer
{
    timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}
-(void)nextImage
{
    int page = (int)pageControl.currentPage;
    
    if (page == 2)//注：这里的2是比总共图片的个数少1
    {
        page = 0;
    }
    else{
        page++;
    }
    
    CGFloat x = page * _scrollView.frame.size.width;
    _scrollView.contentOffset = CGPointMake(x, 0);
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    pageControl.currentPage = _scrollView.contentOffset.x/kScreenWidth;
}


-(void)openADWidthTag:(id)sender
{
    NSArray *array = @[[UIImage imageNamed:@"11"],[UIImage imageNamed:@"22"],[UIImage imageNamed:@"33"]];
    UIButton *button = (UIButton *)sender;
    InfoViewController *infoVC = [InfoViewController new];
    [infoVC.imageView setImage:array[button.tag - 100]];
    [self.navigationController pushViewController:infoVC animated:YES];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
