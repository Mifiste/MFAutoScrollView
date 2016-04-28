//
//  ViewController.m
//  MFAutoScrollView
//
//  Created by lanouhn on 16/4/28.
//  Copyright © 2016年 Mifiste. All rights reserved.
//

#import "ViewController.h"

#import "MFAutoScrollView.h"

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *array = [@[@"1.jpg", @"2.jpeg", @"3.jpeg"] mutableCopy];
    NSMutableArray *titleArray = [@[@"test_1", @"test_2", @"test_3"] mutableCopy];
    
    MFAutoScrollView *autoScrollView = [[MFAutoScrollView alloc] initWithFrame:CGRectMake(0, 20, kWidth, 200) WithImageArray:array TitleArray:titleArray TimeInrerval:5];
    
    [self.view addSubview:autoScrollView];
    
}

@end
