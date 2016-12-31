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

#define cellH 55.5

@interface ZHPlayVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITableViewCell *zeroCell;
@end

@implementation ZHPlayVC

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
    _tableView = [[UITableView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
}

- (UITableViewCell *)zeroCell {
    if (!_zeroCell) {
        _zeroCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        _zeroCell.textLabel.text = @"接着播放";
    }
    return _zeroCell;
}

- (void)viewWillAppear:(BOOL)animated {
    UITabBarController *tabBarControler = (id)UIApplication.sharedApplication.delegate.window.rootViewController;

    [UIView animateWithDuration:0.25 animations:^{
        
        tabBarControler.tabBar.y = ZHMainScreenH;
    }];
}
- (void)viewWillDisappear:(BOOL)animated {
    UITabBarController *tabBarControler = (id)UIApplication.sharedApplication.delegate.window.rootViewController;
    
    [UIView animateWithDuration:0.25 animations:^{
        
        tabBarControler.tabBar.y = ZHMainScreenH - tabBarControler.tabBar.height;
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

static NSString *ZHPlayVCCellID = @"ZHPlayVCCellID";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZHAllMusicCell *cell = [ZHAllMusicCell allMusicCellWithTableView:tableView identifier:ZHPlayVCCellID indexPath:indexPath rowHeight:cellH];
    
    cell.image = [UIImage imageNamed:@"MissingArtworkMusicNote"];
    cell.songNameLbl.text = @"q";
    cell.singerLbl.text = @"a";
    return indexPath.row == 0 ? self.zeroCell : cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.row == 0 ? 44 : cellH;
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
