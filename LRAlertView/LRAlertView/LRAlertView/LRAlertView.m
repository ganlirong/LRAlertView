//
//  LRAlertView.m
//  LRAlertView
//
//  Created by 甘立荣 on 5/8/16.
//  Copyright © 2016 甘立荣. All rights reserved.
//

#import "LRAlertView.h"
#import "LRAlertBackgroundView.h"

#define TitleLabelTag 47890
#define RCFTCancelButongTag 47880
#define RCFTConfirmButongTag 47881

@implementation LRAlertView

- (id)initWithTitle:(NSString *)title
         customView:(UIView *)customView
        buttonBlock:(LRAlertViewButtonBlock)buttonBlock {
    return [self initWithTitle:title
                    customView:customView
             cancelButtonTitle:@"取消"
            confirmButtonTitle:@"确定"
                   buttonBlock:buttonBlock];
}

- (id)initWithTitle:(NSString *)title
         customView:(UIView *)customView
  cancelButtonTitle:(NSString *)cancelButtonTitle
 confirmButtonTitle:(NSString *)confirmButtonTitle
        buttonBlock:(LRAlertViewButtonBlock)buttonBlock {
    self = [super initWithFrame:[UIApplication sharedApplication].delegate.window.bounds];
    if (self) {
        self.title = title;
        self.cancelButtonTitle = cancelButtonTitle;
        self.confirmButtonTitle = confirmButtonTitle;
        self.buttonBlock = buttonBlock;
        self.customView = customView;
        [self initAlertView];
    }
    return self;
}

- (void)initAlertView {
    
    LRAlertBackgroundView *bgView = [[LRAlertBackgroundView alloc] initWithFrame:self.bounds];
    [self addSubview:bgView];
    
    CGFloat contentsViewHeight = _title ? 50 : 0;
    CGRect customFrame = _customView.frame;
    customFrame.origin.y = contentsViewHeight;
    
    contentsViewHeight += customFrame.size.height;
    contentsViewHeight += 40;
    
    CGFloat bgWidth = LRAlertScreenWidth - 40;
    
    UIImage *bgImage = [UIImage imageNamed:@"pop_bg.png"];
    bgImage = [bgImage stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    UIImageView *bgImageView = [[UIImageView alloc] init];
    bgImageView.userInteractionEnabled = YES;
    bgImageView.image = bgImage;
    bgImageView.frame = CGRectMake(20, (LRAlertScreenHeight - contentsViewHeight)/2, bgWidth, contentsViewHeight);
    [self addSubview:bgImageView];
    
    if (_title) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.tag = TitleLabelTag;
        titleLabel.frame = CGRectMake(20, 20, LRAlertScreenWidth - 60, 20);
        titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = _title;
        [bgImageView addSubview:titleLabel];
    }
    
    CGFloat customViewLeft = (bgWidth - customFrame.size.width)/2;
    customFrame.origin.x = customViewLeft;
    _customView.frame = customFrame;
    [bgImageView addSubview:_customView];
    
    CGFloat buttonTop = contentsViewHeight - 40;
    NSInteger buttonCount = _confirmButtonTitle ? 2 : 1;
    CGFloat buttonWidth = bgWidth/buttonCount;
    for (int i = 0; i < buttonCount; i++) {
        
        UIImageView *sepVLineView = [[UIImageView alloc] init];
        sepVLineView.contentMode = UIViewContentModeCenter;
        sepVLineView.tag = 30001 + i;
        sepVLineView.backgroundColor = [UIColor grayColor];
        sepVLineView.frame = i == 0 ? CGRectMake(0, buttonTop, bgWidth, 0.5) :
        CGRectMake(buttonWidth, buttonTop, 0.5, 40);
        [bgImageView addSubview:sepVLineView];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(buttonWidth*i, buttonTop, buttonWidth, 40);
        button.adjustsImageWhenHighlighted = NO;
        NSString *title = i == 0 ? _cancelButtonTitle : _confirmButtonTitle;
        button.tag = i == 0 ? RCFTCancelButongTag : RCFTConfirmButongTag;
        button.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        [button setTitle:title forState:UIControlStateNormal];
        UIColor *buttonColor = [UIColor colorWithRed:0/255.0 green:127/255.0 blue:255/255.0 alpha:1];
        [button setTitleColor:buttonColor forState:UIControlStateNormal];
        [button addTarget:self
                   action:@selector(buttonAction:)
         forControlEvents:UIControlEventTouchUpInside];
        
        [bgImageView addSubview:button];
        
    }
    
}

- (void)buttonAction:(UIButton *)button {
    NSUInteger index = button.tag == RCFTCancelButongTag ? 0 : 1;
    if (_buttonBlock) {
        BOOL isSuccess = _buttonBlock(index);
        if (isSuccess) {
            self.hidden = YES;
            [self removeFromSuperview];
        }
    }
}

- (void)show {
    [[UIApplication sharedApplication].delegate.window addSubview:self];
}

@end
