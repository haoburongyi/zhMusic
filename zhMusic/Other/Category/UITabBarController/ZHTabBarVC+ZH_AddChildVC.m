//
//  ZHTabBarVC+ZH_AddChildVC.m
//  zhMusic
//
//  Created by 张淏 on 16/12/21.
//  Copyright © 2016年 张淏. All rights reserved.
//

#import "ZHTabBarVC+ZH_AddChildVC.h"

@implementation ZHTabBarVC (ZH_AddChildVC)

- (void)addChildViewController:(UIViewController *)childController title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName imageInsets:(UIEdgeInsets)imageInsets titlePosition:(UIOffset)titlePosition navigationClass:(Class)cla {
    
    [self configureChildViewController:childController title:title imageName:imageName selectedImageName:selectedImageName imageInsets:imageInsets titlePosition:titlePosition];
    
    id nav = nil;
    if (cla == nil) {
        nav = [[UINavigationController alloc] initWithRootViewController:childController];
    } else {
        nav = [[cla alloc] initWithRootViewController:childController];
    }
    
    [self addChildViewController:nav];
    
}
- (void)configureChildViewController:(UIViewController *)childVC title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName imageInsets:(UIEdgeInsets)imageInsets titlePosition:(UIOffset)titlePosition {
    childVC.title = title;
    childVC.tabBarItem.title = title;
    childVC.tabBarItem.image = [UIImage imageNamed:imageName];
    // 不需要渲染
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVC.tabBarItem.imageInsets = imageInsets;
    childVC.tabBarItem.titlePositionAdjustment = titlePosition;
    
}

@end
