//
//  ZHPlayVC.m
//  zhMusic
//
//  Created by 张淏 on 16/12/30.
//  Copyright © 2016年 张淏. All rights reserved.
//

#import "ZHPlayVC.h"
#import "Header.h"
#import "ZHMiniPlayView.h"
#import "ZHPlayVCUISercive.h"
#import "ZHNavigationVC.h"
#import <UINavigationController+FDFullscreenPopGesture.h>



@interface ZHPlayVC ()
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *cover;
@property (nonatomic, strong) ZHPlayVCUISercive *sercive;
@end

@implementation ZHPlayVC {
    CGRect _presentingFrame;
}

- (void)setCurrentSong:(MPMediaItem *)currentSong {
    _currentSong = currentSong;
    _header.currentSong = currentSong;
}

- (ZHPlayHeader *)header {
    if (_header == nil) {
        _header = [ZHPlayHeader playHeaderWithFrame:CGRectMake(0, 0, self.view.width, 400)];
    }
    return _header;
}

- (ZHPlayVCUISercive *)sercive {
    if (_sercive == nil) {
        _sercive = [[ZHPlayVCUISercive alloc] init];
    }
    return _sercive;
}

- (void)setPlayList:(NSArray<MPMediaItem *> *)playList {
    _playList = playList;
    self.sercive.playList = playList;
    [_tableView reloadData];
}

- (UIView *)cover {
    if (_cover == nil) {
        _cover = [[UIView alloc] initWithFrame:CGRectMake(-ZHMainScreenW, -ZHMainScreenH, ZHMainScreenW * 3, ZHMainScreenH * 3)];
        _cover.backgroundColor = [UIColor blackColor];
        _cover.alpha = 0.2;
    }
    return _cover;
}

static ZHPlayVC *_defaultVC;
+ (instancetype)defaultVC {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _defaultVC = [[ZHPlayVC alloc] init];
        _defaultVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [_defaultVC configureTableView];
        [[NSNotificationCenter defaultCenter] addObserver:_defaultVC selector:@selector(applicationDidBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
    });
    return _defaultVC;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)applicationDidBecomeActive {
    // 进入前台, origin 会归为 {0, 0}
    NSLog(@"%d, %@", self.isViewLoaded, self.view.window);
    NSLog(@"%@", NSStringFromCGPoint(self.presentingViewController.view.origin));
    if (self.isViewLoaded) {// 是否是正在使用的视图
        
        CGFloat x = 1 - 30 / 320.f;
        CGFloat y = 1 - 40 / 667.f;
        if ([self.presentingViewController isKindOfClass:[ZHNavigationVC class]]) {
            ZHNavigationVC *nav = (ZHNavigationVC *)self.presentingViewController;
            UIViewController *vc = nav.viewControllers.lastObject;
            if (vc.fd_prefersNavigationBarHidden) {
                
                self.presentingViewController.view.layer.transform = CATransform3DIdentity;
                self.presentingViewController.view.origin = CGPointZero;
//                vc.view.layer.transform = CATransform3DMakeScale(x, y, 1);
                self.presentingViewController.view.layer.transform = CATransform3DMakeScale(x, y, 1);

            } else {
                self.presentingViewController.view.layer.transform = CATransform3DIdentity;
                self.presentingViewController.view.origin = CGPointZero;
                
                self.presentingViewController.view.layer.transform = CATransform3DMakeScale(x, y, 1);
            }
        } else {
            self.presentingViewController.view.layer.transform = CATransform3DIdentity;
            self.presentingViewController.view.origin = CGPointZero;
            
            self.presentingViewController.view.layer.transform = CATransform3DMakeScale(x, y, 1);
        }
        
    }
}

- (void)configureTableView {
    
    CGFloat topMargin = ZHSCaleH(28);
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, topMargin, self.view.bounds.size.width, [UIScreen mainScreen].bounds.size.height - topMargin) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate = self.sercive;
    _tableView.dataSource = self.sercive;
    self.sercive.playList = self.playList;
    [self.view addSubview:_tableView];
    
    // 两个角的圆角
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_tableView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(6, 6)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = _tableView.bounds;
    maskLayer.path = maskPath.CGPath;
    _tableView.layer.mask = maskLayer;
    
    _tableView.tableHeaderView = self.header;
}

- (void)viewWillAppear:(BOOL)animated {
    // 调整自己的 frame
    dispatch_async(dispatch_get_main_queue(), ^{
        self.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    });
    
    // 配置 PresentingVC
    [self configuerPresentingVC];
    
    // 移除 miniplay
    [ZHMiniPlayView defaultView].height = 0;
    [UIView animateWithDuration:0.25 animations:^{
        
    }];

    // 隐藏 tabbar
    UITabBarController *tabBarControler = (id)UIApplication.sharedApplication.delegate.window.rootViewController;
    [UIView animateWithDuration:0.25 animations:^{
        
        tabBarControler.tabBar.y = ZHMainScreenH;
    }];
}
- (void)viewWillDisappear:(BOOL)animated {
    
    // 显示 tabbar
    UITabBarController *tabBarControler = (id)UIApplication.sharedApplication.delegate.window.rootViewController;
    [UIView animateWithDuration:0.25 animations:^{
        tabBarControler.tabBar.y = ZHMainScreenH - tabBarControler.tabBar.height;
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)configuerPresentingVC {
    
    [self.presentingViewController.view addSubview:self.cover];
    
    NSLog(@"%@", self.presentingViewController);
    [UIView animateWithDuration:0.25 animations:^{
        CGFloat x = 1 - 30 / 320.f;
        CGFloat y = 1 - 40 / 667.f;
        // 这里如果没有 navigation, 直接设置 corner 是可以的, 如果有, 需要设置 navigation.navigationbar 的 _UIBarBackground 的 cornerRadius
        if ([self.presentingViewController isKindOfClass:[ZHNavigationVC class]]) {
            ZHNavigationVC *nav = (ZHNavigationVC *)self.presentingViewController;
            UIViewController *vc = nav.viewControllers.lastObject;
            if (vc.fd_prefersNavigationBarHidden) {
                [self setPresentingViewCornerRadius:6];
                self.presentingViewController.view.layer.transform = CATransform3DMakeScale(x, y, 1);
            } else {
                [self setNavCornerRadius:6];
                self.presentingViewController.view.layer.transform = CATransform3DMakeScale(x, y, 1);
            }
        } else {
            [self setPresentingViewCornerRadius:6];
            self.presentingViewController.view.layer.transform = CATransform3DMakeScale(x, y, 1);
        }
    }];
}
- (void)disMiss {
    
    
    
    [self.cover removeFromSuperview];
    [UIView animateWithDuration:0.25 animations:^{
        self.presentingViewController.view.layer.transform = CATransform3DIdentity;
    }];
    if ([self.presentingViewController isKindOfClass:[UINavigationController class]]) {
        ZHNavigationVC *nav = (ZHNavigationVC *)self.presentingViewController;
        UIViewController *vc = nav.viewControllers.lastObject;
        if (vc.fd_prefersNavigationBarHidden) {
//            [self setPresentingViewCornerRadius:0];
            [self setPresentingViewCornerRadius:0];
        } else {
            [self setNavCornerRadius:0];
        }
    } else {
        [self setNavCornerRadius:0];
    }
    [UIView animateWithDuration:0.25 animations:^{
        [ZHMiniPlayView defaultView].height = 63.5;
    }];
    [self dismissViewControllerAnimated:YES completion:^{
        // 显示 miniplay
//        [[UIApplication sharedApplication].keyWindow bringSubviewToFront:[ZHMiniPlayView defaultView]];
        
        
    }];
}

- (void)setPresentingViewCornerRadius:(CGFloat)radius {
    
    UIView *tempView = self.presentingViewController.view;
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:tempView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = tempView.bounds;
    maskLayer.path = maskPath.CGPath;
    tempView.layer.mask = maskLayer;
}

- (void)setNavCornerRadius:(CGFloat)radius {
    UITabBarController *tabBarControler = (id)UIApplication.sharedApplication.delegate.window.rootViewController;
    UINavigationController *navigationController = tabBarControler.selectedViewController;
    
    // 因为 _UIBarBackground 在最底层
    UIView *_UIBarBackground = [navigationController.navigationBar.subviews firstObject];
    NSLog(@"%@", navigationController.navigationBar);
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_UIBarBackground.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = _UIBarBackground.bounds;
    maskLayer.path = maskPath.CGPath;
    _UIBarBackground.layer.mask = maskLayer;
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
