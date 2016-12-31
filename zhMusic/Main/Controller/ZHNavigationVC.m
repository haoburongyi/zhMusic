//
//  ZHNavigationVC.m
//  zhMusic
//
//  Created by 张淏 on 16/12/27.
//  Copyright © 2016年 张淏. All rights reserved.
//

#import "ZHNavigationVC.h"
#import "Header.h"
#import <UINavigationController+FDFullscreenPopGesture.h>

@interface ZHNavigationVC ()

@end

@implementation ZHNavigationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationBar.tintColor = ZHRedColor;
    // navigationBar.backgroundColor 在属性 translucent = YES 时时没有用的
    self.navigationBar.translucent = NO;
    self.navigationBar.backgroundColor = ZHNavColor;
    
// navigationBar 隐藏分割线的四种方法, 前三种不推荐
//    self.navigationBar.clipsToBounds = YES;1
    
//    self.navigationBar.barStyle = UIBarStyleBlackTranslucent;2
    
//    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];3
//    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];3
    
//    4
    for (UIView *views in self.navigationBar.subviews) {
        for (UIView *view in views.subviews) {
            if ([view isKindOfClass:[UIImageView class]]) {
                view.hidden = YES;
            }
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
