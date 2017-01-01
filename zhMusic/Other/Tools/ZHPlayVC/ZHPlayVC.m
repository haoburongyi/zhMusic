//
//  ZHPlayVC.m
//  zhMusic
//
//  Created by 张淏 on 16/12/30.
//  Copyright © 2016年 张淏. All rights reserved.
//

#import "ZHPlayVC.h"
#import "ZHAllMusicCell.h"
#import "UIImage+Extension.h"
#import "Header.h"
#import "ZHMiniPlayView.h"
#import "UIImage+Extension.h"
#import <objc/runtime.h>

#define cellH 55.5

@interface ZHPlayVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITableViewCell *zeroCell;
@property (nonatomic, strong) UIView *cover;
@end

@implementation ZHPlayVC

- (void)setPlayList:(NSArray<MPMediaItem *> *)playList {
    _playList = playList;
    [_tableView reloadData];
}

- (UIView *)cover {
    if (_cover == nil) {
        _cover = [[UIView alloc] initWithFrame:CGRectMake(-ZHMainScreenW, -ZHMainScreenH, ZHMainScreenW * 3, ZHMainScreenH * 3)];
        _cover.backgroundColor = [UIColor blackColor];
        _cover.alpha = 0.4;
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
    });
    return _defaultVC;
}


- (void)configureTableView {
    
    CGFloat topMargin = 28;
    // tableView 底部是 self.view, 而 self.view 是透明的
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, topMargin, self.view.bounds.size.width, [UIScreen mainScreen].bounds.size.height - topMargin)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    
    // 两个角的圆角
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bgView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(6, 6)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = bgView.bounds;
    maskLayer.path = maskPath.CGPath;
    bgView.layer.mask = maskLayer;
    
    _tableView = [[UITableView alloc] initWithFrame:bgView.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [bgView addSubview:_tableView];

}

- (UITableViewCell *)zeroCell {
    if (!_zeroCell) {
        _zeroCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        _zeroCell.textLabel.text = @"接着播放";
    }
    return _zeroCell;
}

- (void)viewWillAppear:(BOOL)animated {
    // 调整自己的 frame
    dispatch_async(dispatch_get_main_queue(), ^{
        self.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    });
    
    // 配置 PresentingVC
    [self configuerPresentingVC];
    
    // 移除 miniplay
    [[UIApplication sharedApplication].keyWindow sendSubviewToBack:[ZHMiniPlayView defaultView]];

    // 隐藏 tabbar
    UITabBarController *tabBarControler = (id)UIApplication.sharedApplication.delegate.window.rootViewController;
    [UIView animateWithDuration:0.25 animations:^{
        
        tabBarControler.tabBar.y = ZHMainScreenH;
    }];
}
- (void)viewWillDisappear:(BOOL)animated {
    
    // 显示 miniplay
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:[ZHMiniPlayView defaultView]];
    
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
        
        // 这里改 frame 会导致 view 层显示问题
//        self.presentingViewController.view.frame = CGRectMake(15, 20, self.presentingViewController.view.bounds.size.width - 30, self.presentingViewController.view.bounds.size.height);
        // 这里如果没有 navigation, 直接设置 corner 是可以的, 如果有, 需要设置 navigation.navigationbar 的 _UIBarBackground 的 cornerRadius
//        self.presentingViewController.view.layer.cornerRadius = 6;
        [self setNavCornerRadius:6];
        
        CGFloat x = 1 - 30 / 320.f;
        CGFloat y = 1 - 40 / 667.f;
        self.presentingViewController.view.layer.transform = CATransform3DMakeScale(x, y, 1);
    }];
}
- (void)disMiss {
    [self.cover removeFromSuperview];
    [UIView animateWithDuration:0.25 animations:^{
        
        [self setNavCornerRadius:0];
        self.presentingViewController.view.layer.transform = CATransform3DIdentity;
    }];

    [self dismissViewControllerAnimated:YES completion:nil];
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


#pragma mark - tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _playList.count + 1;
}

static NSString *ZHPlayVCCellID = @"ZHPlayVCCellID";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath != 0) {
        ZHAllMusicCell *cell = [ZHAllMusicCell allMusicCellWithTableView:tableView identifier:ZHPlayVCCellID indexPath:indexPath rowHeight:cellH];
        
        MPMediaItem *song = _playList[indexPath.row - 1];
        
        cell.image = [UIImage defaultImageWithSongItem:song size:cell.artworkImg.size];
        cell.songNameLbl.text = [song valueForProperty:MPMediaItemPropertyTitle];
        cell.singerLbl.text = [song valueForProperty:MPMediaItemPropertyArtist];
        return cell;
    } else {
        return self.zeroCell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.row == 0 ? 44 : cellH;
}

#pragma mark - tableViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    // 下拉距离
    if (scrollView.contentOffset.y < - 80 && scrollView.dragging) {
        [self disMiss];
    }
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
