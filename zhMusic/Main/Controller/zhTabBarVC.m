//
//  zhTabBarVC.m
//  zhMusic
//
//  Created by 张淏 on 16/12/19.
//  Copyright © 2016年 张淏. All rights reserved.
//

#import "zhTabBarVC.h"

@interface zhTabBarVC ()

@end

@implementation zhTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configureChildViewControllers];
}

- (void)configureChildViewControllers {
    // 音乐
    [self addMusicController];
    // 搜索
    [self addSearchViewController];
}

- (void)addMusicController {
    
}
- (void)addSearchViewController {
    
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
