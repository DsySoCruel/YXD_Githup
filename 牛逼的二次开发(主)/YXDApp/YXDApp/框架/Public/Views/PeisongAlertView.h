//
//  PeisongAlertView.h
//  YXDApp
//
//  Created by daishaoyang on 2018/2/7.
//  Copyright © 2018年 beijixing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderProducModel.h"

@interface PeisongAlertView : UIView

//@property (nonatomic, copy) dispatch_block_t cancelBlock;
//@property (nonatomic, copy) dispatch_block_t otherBlock;

///**创建弹出框成果转化**/
//- (id)initWithTitle:(NSString *)title
//            message:(NSString *)content
//  cancelButtonTitle:(NSString *)leftTitle
//   otherButtonTitle:(NSString *)rigthTitle;
///**创建弹出框个推弹框**/
//- (id)initGetuiWithTitle:(NSString *)title
//                 message:(NSString *)content
//       cancelButtonTitle:(NSString *)leftTitle
//        otherButtonTitle:(NSString *)rigthTitle;

/**创建运费提醒弹框**/
- (id)initGetuiWithTitle:(NSString *)title
                 orderProducModel:(OrderProducModel *) model;

- (void)show;
- (void)hidden;
@end
