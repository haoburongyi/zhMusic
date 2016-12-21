//
//  ZHTabBarVC+ZH_AddChildVC.h
//  zhMusic
//
//  Created by 张淏 on 16/12/21.
//  Copyright © 2016年 张淏. All rights reserved.
//

#import "ZHTabBarVC.h"

@interface ZHTabBarVC (ZH_AddChildVC)

- (void)addChildViewController:(UIViewController *)childController title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName imageInsets:(UIEdgeInsets)imageInsets titlePosition:(UIOffset)titlePosition navigationClass:(Class)cla;

- (void)configureChildViewController:(UIViewController *)childVC title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName imageInsets:(UIEdgeInsets)imageInsets titlePosition:(UIOffset)titlePosition;

@end
