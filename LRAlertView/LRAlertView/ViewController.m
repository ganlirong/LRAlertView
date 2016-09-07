//
//  ViewController.m
//  LRAlertView
//
//  Created by 甘立荣 on 5/8/16.
//  Copyright © 2016 甘立荣. All rights reserved.
//

#import "ViewController.h"
#import "LRAlertView/LRAlertView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *planDetailButton = [UIButton buttonWithType:UIButtonTypeCustom];
    planDetailButton.frame = CGRectMake(240, 422, 70, 22);
    planDetailButton.tag = 12345;
    [planDetailButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [planDetailButton setTitle:@"测试AlertView" forState:UIControlStateNormal];
    planDetailButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [planDetailButton addTarget:self
                         action:@selector(planDetailButtonAction)
               forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:planDetailButton];
}

- (void)planDetailButtonAction {
    UIView *textView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, LRAlertScreenWidth - 20, 300)];
    //textView.backgroundColor = [UIColor redColor];
    LRAlertView *view = [[LRAlertView alloc] initWithTitle:@"测试"
                                                customView:textView
                                         cancelButtonTitle:@"取消"
                                        confirmButtonTitle:@"确定"
                                               buttonBlock:^(NSUInteger buttonIndex) {
                                                   NSLog(@"索引:%zd", buttonIndex);
                                                   return YES;
                                               }];
    [view show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
