//
//  ZHTabBarVC.m
//  zhMusic
//
//  Created by 张淏 on 16/12/21.
//  Copyright © 2016年 张淏. All rights reserved.
//

#import "ZHTabBarVC.h"
#import "Header.h"
#import "ZHTabBarVC+ZH_AddChildVC.h"
#import "ZHMusicVC.h"
#import "ZHNavigationVC.h"

#warning 测试,以后删除
#import <Realm.h>

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
    
    [self addChildViewController:musicVC title:@"音乐资料库" imageName:@"LibraryTabIcon_19x28_" selectedImageName:@"LibraryTabIcon_19x28_" imageInsets:UIEdgeInsetsZero titlePosition:UIOffsetZero navigationClass:[ZHNavigationVC class]];
}
- (void)addSearchViewController {
    
    UIViewController *vc = [UIViewController new];
    UIButton *btn = [[UIButton alloc] init];
    btn.frame = CGRectMake(100, 100, 100, 100);
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(removeRealmAllObject) forControlEvents:UIControlEventTouchUpInside];
    [vc.view addSubview:btn];
    vc.view.backgroundColor = [UIColor whiteColor];
    
    [self addChildViewController:vc title:@"搜索" imageName:@"LibraryTabIcon_19x28_" selectedImageName:@"LibraryTabIcon_19x28_" imageInsets:UIEdgeInsetsZero titlePosition:UIOffsetZero navigationClass:[ZHNavigationVC class]];
}

- (void)removeRealmAllObject {
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm deleteAllObjects];
    [realm commitWriteTransaction];
    NSLog(@"deleteSuccess");
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
