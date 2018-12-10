//
//  RatingBar.h
//  MyRatingBar
//
//  Created by Leaf on 14-8-28.
//  Copyright (c) 2014年 Leaf. All rights reserved.
//


#import <UIKit/UIKit.h>

@class RatingBar;
@protocol RatingBarDelegate<NSObject>
@optional
- (void)starRateView:(RatingBar *)starRateView scroePercentDidChange:(NSInteger)newScorePercent;
@end
@interface RatingBar : UIView

@property (nonatomic,assign) NSInteger starNumber;
/*
 *调整底部视图的颜色
 */
@property (nonatomic,strong) UIColor *viewColor;


@property (nonatomic, weak) id<RatingBarDelegate>delegate;

/*
 *是否允许可触摸
 */
@property (nonatomic,assign) BOOL enable;


@end
