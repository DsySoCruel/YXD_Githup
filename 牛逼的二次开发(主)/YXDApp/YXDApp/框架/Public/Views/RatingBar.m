//
//  RatingBar.m
//  MyRatingBar
//
//  Created by Leaf on 14-8-28.
//  Copyright (c) 2014年 Leaf. All rights reserved.
//


#import "RatingBar.h"
#define ZOOM 0.5f
@interface RatingBar()
@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic,strong) UIView *topView;
@property (nonatomic,assign) CGFloat starWidth;
@end

@implementation RatingBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.bottomView = [[UIView alloc] initWithFrame:self.bounds];
        self.topView = [[UIView alloc] initWithFrame:CGRectZero];
        
        [self addSubview:self.bottomView];
        [self addSubview:self.topView];
        
        self.topView.clipsToBounds = YES;
        self.topView.userInteractionEnabled = NO;
        self.bottomView.userInteractionEnabled = NO;
        self.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        [self addGestureRecognizer:tap];
        [self addGestureRecognizer:pan];
        
        //
        CGFloat width = frame.size.height;
        CGFloat W = frame.size.width / 6;
        self.starWidth = W;
        for(int i = 0; i<5 ; i++){
            UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width*ZOOM, width*ZOOM)];
            img.center = CGPointMake((i+1)*W, frame.size.height/2);
            img.image = [UIImage imageNamed:@"icon_72"];
            [self.bottomView addSubview:img];
            UIImageView *img2 = [[UIImageView alloc] initWithFrame:img.frame];
            img2.center = img.center;
            img2.image = [UIImage imageNamed:@"icon_71"];
            [self.topView addSubview:img2];
        }
        self.enable = YES;
        
    }
    return self;
}
-(void)setViewColor:(UIColor *)backgroundColor{
    if(_viewColor != backgroundColor){
        self.backgroundColor = backgroundColor;
        self.topView.backgroundColor = backgroundColor;
        self.bottomView.backgroundColor = backgroundColor;
    }
}
-(void)setStarNumber:(NSInteger)starNumber{
    if(_starNumber != starNumber){
        _starNumber = starNumber;
        self.topView.frame = CGRectMake(0, 0, self.starWidth * (starNumber+1) +self.mj_w * 0.1, self.bounds.size.height);
    }
}
-(void)tap:(UITapGestureRecognizer *)gesture{
    if(self.enable){
        CGPoint point = [gesture locationInView:self];
        NSInteger count = 0;
        if ((point.x - self.mj_w * 0.1) < 0) {
            count = 0;
        }else{
            count = (int)((point.x - self.mj_w * 0.1)/self.starWidth) + 1;
        }
        self.topView.frame = CGRectMake(0, 0, self.starWidth * count + self.mj_w * 0.1, self.bounds.size.height);
        if(count > 4){
            _starNumber = 4;
        }else{
            _starNumber = count;
        }
        if ([self.delegate respondsToSelector:@selector(starRateView:scroePercentDidChange:)]) {
            [self.delegate starRateView:self scroePercentDidChange:_starNumber];
        }
    }
}
-(void)pan:(UIPanGestureRecognizer *)gesture{
    if(self.enable){
        CGPoint point = [gesture locationInView:self];
        NSInteger count = (int)((point.x - self.mj_w * 0.1)/self.starWidth);
        if(count>=0 && count<=4 && _starNumber!=count){
            self.topView.frame = CGRectMake(0, 0, self.starWidth*count + self.mj_w * 0.1, self.bounds.size.height);
            _starNumber = count;
        }
        if ([self.delegate respondsToSelector:@selector(starRateView:scroePercentDidChange:)]) {
            [self.delegate starRateView:self scroePercentDidChange:_starNumber];
        }
    }
}

@end
