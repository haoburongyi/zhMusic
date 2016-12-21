//
//  ZHTabBarVC.m
//  zhMusic
//
//  Created by 张淏 on 16/12/21.
//  Copyright © 2016年 张淏. All rights reserved.
//

#import "ZHTabBarVC.h"
#import "MusicPch.h"
#import "ZHTabBarVC+ZH_AddChildVC.h"
#import "ZHMusicVC.h"

@interface ZHTabBarVC ()

@end

@implementation ZHTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configureTabBar];
    
    [self configureChildViewControllers];
}

- (void)configureTabBar {
    
    [self.tabBar setTintColor:ZHRGBColor(255, 45, 113)];
}

- (void)configureChildViewControllers {
    // 音乐
    [self addMusicController];
    // 搜索2
    [self addSearchViewController];
}

- (void)addMusicController {
    
    ZHMusicVC *musicVC = [[ZHMusicVC alloc] init];
    
    [self addChildViewController:musicVC title:@"音乐资料库" imageName:@"LibraryTabIcon_19x28_" selectedImageName:@"LibraryTabIcon_19x28_" imageInsets:UIEdgeInsetsZero titlePosition:UIOffsetZero navigationClass:nil];
}
- (void)addSearchViewController {
    
    ZHMusicVC *musicVC = [[ZHMusicVC alloc] init];
    
    [self addChildViewController:musicVC title:@"音乐资料库" imageName:@"LibraryTabIcon_19x28_" selectedImageName:@"LibraryTabIcon_19x28_" imageInsets:UIEdgeInsetsZero titlePosition:UIOffsetZero navigationClass:nil];
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
