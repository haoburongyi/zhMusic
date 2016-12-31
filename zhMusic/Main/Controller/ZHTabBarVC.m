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
#import "ZHMiniPlayView.h"

#warning 测试,以后删除
#import <Realm.h>
#import <JPFPSStatus.h>

@interface ZHTabBarVC ()

@end

@implementation ZHTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configureTabBar];
    [self configereMiniPlayView];
    [self configureChildViewControllers];
}

- (void)test {
    [[NSNotificationCenter defaultCenter] postNotificationName:PlayMusicNoti object:PlayMusicNoti];
    
    UITabBarController *tabBarControler = (id)UIApplication.sharedApplication.delegate.window.rootViewController;
    
    [UIView animateWithDuration:0.25 animations:^{
        
        if (tabBarControler.tabBar.y == ZHMainScreenH) {
            tabBarControler.tabBar.y = ZHMainScreenH - 49;
        } else {
            tabBarControler.tabBar.y = ZHMainScreenH;
        }
    }];
    NSLog(@"%@", tabBarControler.tabBar);
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, -44, ZHMainScreenW, 44)];
    view.backgroundColor = [UIColor redColor];
    [tabBarControler.tabBar addSubview:view];

}

- (void)configureTabBar {
    
    [self.tabBar setTintColor:ZHRGBColor(255, 45, 113)];
    self.tabBar.barTintColor = [UIColor whiteColor];
    
}

- (void)configereMiniPlayView {
    ZHMiniPlayView *view = [ZHMiniPlayView defaultView];
    [self.tabBar addSubview:view];
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
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"清空 realm 数据" forState: UIControlStateNormal];
    [btn addTarget:self action:@selector(removeRealmAllObject) forControlEvents:UIControlEventTouchUpInside];
    [vc.view addSubview:btn];
    vc.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *JPFPSStatusOpen = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 100, 100)];
    JPFPSStatusOpen.backgroundColor = [UIColor blueColor];
    [JPFPSStatusOpen setTitle:@"open" forState:UIControlStateNormal];
    [JPFPSStatusOpen addTarget:self action:@selector(_JPFPSStatusOpen) forControlEvents:UIControlEventTouchUpInside];
    [vc.view addSubview:JPFPSStatusOpen];
    
    UIButton *JPFPSStatusClose = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 100, 100)];
    JPFPSStatusClose.backgroundColor = [UIColor blueColor];
    [JPFPSStatusClose setTitle:@"close" forState:UIControlStateNormal];
    [JPFPSStatusClose addTarget:self action:@selector(_JPFPSStatusClose) forControlEvents:UIControlEventTouchUpInside];
    [vc.view addSubview:JPFPSStatusClose];
    
    [self addChildViewController:vc title:@"搜索" imageName:@"LibraryTabIcon_19x28_" selectedImageName:@"LibraryTabIcon_19x28_" imageInsets:UIEdgeInsetsZero titlePosition:UIOffsetZero navigationClass:[ZHNavigationVC class]];
}

- (void)removeRealmAllObject {
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm deleteAllObjects];
    [realm commitWriteTransaction];
    NSLog(@"deleteSuccess");
}
- (void)_JPFPSStatusOpen {
    [[JPFPSStatus sharedInstance] open];
}
- (void)_JPFPSStatusClose {
    [[JPFPSStatus sharedInstance] close];
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
