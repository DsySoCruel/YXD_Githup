//
//  HeipCenterModel.h
//  YXDApp
//
//  Created by daishaoyang on 2017/12/13.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeipCenterModelTwoModel : NSObject

@property (nonatomic,strong) NSString *catName;
@property (nonatomic,strong) NSString *articleId;
@property (nonatomic,strong) NSString *catId;
@property (nonatomic,strong) NSString *articleTitle;
@property (nonatomic,strong) NSString *articleImg;

@end


//@interface HeipCenterModelFirstModel : NSObject
//
//@property (nonatomic,strong) NSString *catName;
//@property (nonatomic,strong) NSMutableArray *articlecats;
//
//@end

@interface HeipCenterModel : NSObject

@property (nonatomic,strong) NSString *catName;
@property (nonatomic,strong) NSMutableArray *articlecats;


//@property (nonatomic,strong) HeipCenterModelFirstModel *b;
//@property (nonatomic,strong) HeipCenterModelFirstModel *c;
//@property (nonatomic,strong) HeipCenterModelFirstModel *d;
//@property (nonatomic,strong) HeipCenterModelFirstModel *e;
//@property (nonatomic,strong) HeipCenterModelFirstModel *f;

@end



