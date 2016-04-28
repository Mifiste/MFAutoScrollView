//
//  MFAutoScrollView.h
//  MFAutoScrollView
//
//  Created by lanouhn on 16/4/28.
//  Copyright © 2016年 Mifiste. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MFAutoScrollViewDelegate <NSObject>
- (void)clickImageAtIndex:(NSInteger)index;

@end

@interface MFAutoScrollView : UIView
@property (nonatomic, assign) id<MFAutoScrollViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame WithImageArray:(NSMutableArray <NSString *>*)imageArray TitleArray:(NSMutableArray <NSString *>*)titleArray TimeInrerval:(NSTimeInterval)timeInterval;

@end
