//
//  ZHAllMusicVC.m
//  zhMusic
//
//  Created by 张淏 on 16/12/27.
//  Copyright © 2016年 张淏. All rights reserved.
//

#import "ZHAllMusicVC.h"
#import <MediaPlayer/MediaPlayer.h>
#import "Header.h"
#import "ZHMusicInfo.h"
#import "ZHAllMusicCell.h"
#import "ZHPlayMusicListManager.h"
#import "ZHPlayMusicManager.h"


#define HeaderHeight 25
#define ShuffleAllHeaderH 40

@interface ZHAllMusicVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSDictionary *allMusic;     // 数据源
@property (nonatomic, strong) NSArray *headerArr;    // header 数据源
@end

@implementation ZHAllMusicVC {
    UIView              *_headerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"歌曲";
    
    [self configureTableView];
    
    [[ZHPlayMusicListManager defaultManager] loadAllMusicComplation:^(NSArray *header, NSDictionary *allMusic) {
        _headerArr = header;
        _allMusic = allMusic;
        [_tableView reloadData];
    }];
    
    
}


- (void)configureTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, ShuffleAllHeaderH, self.view.width, self.view.height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView setRowHeight:55.5];
    [_tableView setSectionHeaderHeight:HeaderHeight];
    [_tableView setSectionIndexColor:ZHRedColor];
    
//    UIView *header = [self createHeaderWithFrame:CGRectMake(0, -ShuffleAllHeaderH, self.view.width, ShuffleAllHeaderH)];
//    [_tableView addSubview:header];
//    [_tableView setContentInset:UIEdgeInsetsMake(ShuffleAllHeaderH, 0, 0, 0)];
    
    _tableView.tableFooterView = [UIView new];
    
    [self.view addSubview:_tableView];
    
    [self prepareHeaderView];
}

- (void)prepareHeaderView {
    _headerView = [self createHeaderWithFrame:CGRectMake(0, 0, self.view.width, ShuffleAllHeaderH)];
    _headerView.backgroundColor = ZHNavColor;
    [self.view addSubview:_headerView];
}

- (UIView *)createHeaderWithFrame:(CGRect)frame {
    UIView *header = [[UIView alloc] initWithFrame:frame];
    header.backgroundColor = _tableView.backgroundColor;
    
    UILabel *shuffleAll = [UILabel new];
    shuffleAll.text = @"随机播放";
    shuffleAll.font = [UIFont systemFontOfSize:12];
    shuffleAll.textColor = ZHRedColor;
    [shuffleAll sizeToFit];
    shuffleAll.origin = CGPointMake(20, header.height * 0.5 - shuffleAll.height * 0.5);
    [header addSubview:shuffleAll];
    
    UIImageView *shuffleAllImg = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"NowPlaying-Shuffle_31x20_"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
    shuffleAllImg.tintColor = ZHRedColor;
    [shuffleAllImg sizeToFit];
    shuffleAllImg.origin = CGPointMake(header.width - shuffleAllImg.width - 20, header.height * 0.5 - shuffleAllImg.height * 0.5);
    [header addSubview:shuffleAllImg];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(15, 0, header.width - 15 - 15, 0.5)];
    line1.backgroundColor = ZHRGBColor(200, 200, 200);
    [header addSubview:line1];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(15, header.height - 0.5, header.width - 15 - 15, 0.5)];
    line2.backgroundColor = ZHRGBColor(200, 200, 200);
    [header addSubview:line2];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shufflePlay:)];
    [header addGestureRecognizer:tap];
    return header;
}
#pragma - mark 随机播放
- (void)shufflePlay:(UITapGestureRecognizer *)tap {
    NSLog(@"%s", __func__);
    [UIView animateWithDuration:0.1 animations:^{
        tap.view.backgroundColor = ZHRGBColor(217, 217, 217);
    } completion:^(BOOL finished) {
        tap.view.backgroundColor = ZHNavColor;
    }];
}

#pragma - mark tableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _headerArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *key = _headerArr[section];
    NSArray *arr = _allMusic[key];
    return arr.count;
}

static NSString *ZHAllMusicCellID = @"ZHAllMusicCellID";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZHAllMusicCell *cell = [ZHAllMusicCell allMusicCellWithTableView:tableView identifier:ZHAllMusicCellID indexPath:indexPath rowHeight:tableView.rowHeight];
    
    NSString *key = _headerArr[indexPath.section];
    NSArray *arr = _allMusic[key];
    
    MPMediaItem *song = arr[indexPath.row];
    MPMediaItemArtwork *artwork = [song valueForProperty:MPMediaItemPropertyArtwork];
    UIImage *img = [artwork imageWithSize:CGSizeMake(48, 48)];
    cell.image = img ? img : [UIImage imageNamed:@"MissingArtworkMusicNote"];
    cell.songNameLbl.text = [song valueForProperty: MPMediaItemPropertyTitle];
    cell.singerLbl.text = [song valueForProperty:MPMediaItemPropertyArtist];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, HeaderHeight)];
    header.backgroundColor = ZHNavColor;
    
    UILabel *title = [UILabel new];
    title.text = _headerArr[section];
    title.font = [UIFont boldSystemFontOfSize:12];
    [title sizeToFit];
    title.origin = CGPointMake(20, HeaderHeight * 0.5 - title.height * 0.5);
    [header addSubview:title];
    
    return header;
}

#pragma - mark tableViewDelegate

#pragma - mark 实现右侧索引
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return _headerArr;
}

#pragma - mark 下拉跟随
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offset = scrollView.contentOffset.y + scrollView.contentInset.top;
    //    NSLog(@"%f", offset);
    
    // 放大
    if (offset <= 0) {
        // 调整 headView
        _headerView.y = offset == 0 ? offset : -offset;
    } else {
        // 整体移动
        _headerView.y = 0;
        
        // headerView 最小 y 值
//        CGFloat min = fabs(ShuffleAllHeaderH - 64.0) + 24;
//        _headerView.y = -MIN(min, offset);
//        NSLog(@"%f, %f, %f", _headerView.y, min, offset);
        
//        _tableView.y = _headerView.y + ShuffleAllHeaderH;
        
        
        // 设置透明度
        // NSLog(@"%f", offset / min);
        // 根据输出可以知道 offset / min == 1 的不可见
//        CGFloat progress = 1 - (offset / min);
        
        // 根据透明度，来修改状态栏的颜色
//        _statusBarStyle = (progress < 0.5) ? UIStatusBarStyleDefault : UIStatusBarStyleLightContent;
        // 主动更新状态栏
//        [self.navigationController setNeedsStatusBarAppearanceUpdate];
    }
}

#pragma - mark 播放音乐
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *key = _headerArr[indexPath.section];
    NSArray *arr = _allMusic[key];
    MPMediaItem *song = arr[indexPath.row];
    
    [[ZHPlayMusicManager defaultManager] playMusicWithSongUrl:[song valueForProperty:MPMediaItemPropertyAssetURL] didComplete:^{
        
    }];
    
    
}


- (void)dealloc {
    NSLog(@"%s", __func__);
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
