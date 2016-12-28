//
//  ZHAllMusicVC.m
//  zhMusic
//
//  Created by 张淏 on 16/12/27.
//  Copyright © 2016年 张淏. All rights reserved.
//

#import "ZHAllMusicVC.h"
#import <Realm.h>
#import "Header.h"
#import "ZHMusicInfo.h"
#import "ZHAllMusicCell.h"

@interface ZHAllMusicVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *allMusic;// 数据源
@end

@implementation ZHAllMusicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self configureTableView];
    [self loadAllMusicComplation:^{
        [_tableView reloadData];
    }];
}
- (void)configureTableView {
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 55.5;
    
    UIView *header = [self createHeader];
    
    _tableView.tableFooterView = [UIView new];
    
    [self.view addSubview:_tableView];
}
- (UIView *)createHeader {
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 40)];
    
    UILabel *shuffleAll = [UILabel new];
    shuffleAll.text = @"随机播放";
    
    return header;
}

- (void)loadAllMusicComplation:(void(^)())complation {
    
    _allMusic = [NSMutableArray array];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        RLMResults *musics = [ZHMusicInfo allObjects];
        NSLog(@"hehe");
        for (ZHMusicInfo *musicInfo in musics) {
            MPMediaItem *song = [NSKeyedUnarchiver unarchiveObjectWithData:musicInfo.data];
            [_allMusic addObject:song];
        }
        NSLog(@"hehe");
        dispatch_async(dispatch_get_main_queue(), ^{
            complation();
        });
    });
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _allMusic.count;
}

static NSString *ZHAllMusicCellID = @"ZHAllMusicCellID";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZHAllMusicCell *cell = [ZHAllMusicCell allMusicCellWithTableView:tableView identifier:ZHAllMusicCellID indexPath:indexPath];
    
    MPMediaItem *song = _allMusic[indexPath.row];
    MPMediaItemArtwork *artwork = [song valueForProperty:MPMediaItemPropertyArtwork];
    UIImage *img = [artwork imageWithSize:CGSizeZero];
    cell.imageView.image = img ? img : [UIImage imageNamed:@"MissingArtworkMusicNote"];
    cell.songNameLbl.text = [song valueForProperty: MPMediaItemPropertyTitle];
    cell.singerLbl.text = [song valueForProperty:MPMediaItemPropertyArtist];
    
    return cell;
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
