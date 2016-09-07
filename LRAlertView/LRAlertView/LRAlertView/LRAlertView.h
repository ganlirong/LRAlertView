//
//  LRAlertView.h
//  LRAlertView
//
//  Created by 甘立荣 on 5/8/16.
//  Copyright © 2016 甘立荣. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef BOOL (^LRAlertViewButtonBlock)(NSUInteger index);

//定义设备屏幕的高度
#define LRAlertScreenHeight [UIScreen mainScreen].bounds.size.height

//定义设备屏幕的宽度
#define LRAlertScreenWidth [UIScreen mainScreen].bounds.size.width

@interface LRAlertView : UIView

@property (nonatomic, copy) LRAlertViewButtonBlock buttonBlock;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *cancelButtonTitle;
@property (nonatomic, copy) NSString *confirmButtonTitle;
@property (nonatomic, strong) UIView *customView;

/**
 *  初始化AlertView
 *
 *  @param title       AlertView title
 *  @param customView  自定义的view
 *  @param buttonBlock 点击取消或者确定按钮的事件
 *
 *  @return
 */
- (id)initWithTitle:(NSString *)title
         customView:(UIView *)customView
        buttonBlock:(LRAlertViewButtonBlock)buttonBlock;

/**
 *  初始化AlertView
 *
 *  @param title       AlertView title
 *  @param customView  自定义的view
 *  @param cancelButtonTitle 取消按钮
 *  @param confirmButtonTitle 确定按钮
 *  @param buttonBlock 点击取消或者确定按钮的事件
 *
 *  @return
 */
- (id)initWithTitle:(NSString *)title
         customView:(UIView *)customView
  cancelButtonTitle:(NSString *)cancelButtonTitle
 confirmButtonTitle:(NSString *)confirmButtonTitle
        buttonBlock:(LRAlertViewButtonBlock)buttonBlock;
- (void)show;

@end
