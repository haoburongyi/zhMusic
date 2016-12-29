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
#import "pinyin.h"


#define HeaderHeight 25

@interface ZHAllMusicVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSDictionary *allMusic;     // 数据源
@property (nonatomic, strong) NSArray *headerArr;    // header 数据源
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
    [_tableView setRowHeight:55.5];
    [_tableView setSectionHeaderHeight:HeaderHeight];
    [_tableView setSectionIndexColor:ZHRedColor];
//    UIView *header = [self createHeader];
    
    _tableView.tableFooterView = [UIView new];
    
    [self.view addSubview:_tableView];
}
- (UIView *)createHeader {
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 40)];
    
    UILabel *shuffleAll = [UILabel new];
    shuffleAll.text = @"随机播放";
    
    return header;
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

- (void)loadAllMusicComplation:(void(^)())complation {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        RLMResults *musics = [ZHMusicInfo allObjects];
        
        NSMutableArray *muArr = [NSMutableArray array];
        for (ZHMusicInfo *musicInfo in musics) {
            MPMediaItem *song = [NSKeyedUnarchiver unarchiveObjectWithData:musicInfo.data];
            [muArr addObject:song];
        }
        
        NSDictionary *modelDict = [muArr sortedArrayUsingFirstLetterByKeypath:@"title"];
        NSLog(@"modelDict:%@", modelDict);
        NSLog(@"allKey:%@", modelDict.allKeys);

        NSStringCompareOptions comparisonOptions = NSCaseInsensitiveSearch|NSNumericSearch|
        NSWidthInsensitiveSearch|NSForcedOrderingSearch;
        NSComparator sort = ^(NSString *obj1,NSString *obj2){
            NSRange range = NSMakeRange(0,obj1.length);
            return [obj1 compare:obj2 options:comparisonOptions range:range];
        };
        
        _allMusic = modelDict;
        
        NSMutableArray *tempHeaderArr = [modelDict.allKeys sortedArrayUsingComparator:sort].mutableCopy;
        if ([tempHeaderArr containsObject:@"#"]) {
            [tempHeaderArr removeObject:@"#"];
            [tempHeaderArr addObject:@"#"];
        }
        _headerArr = tempHeaderArr.copy;
        NSLog(@"字符串数组排序结果%@",_headerArr);
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [_tableView reloadData];
        });
    });
    

    
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        RLMResults *musics = [ZHMusicInfo allObjects];
//        
//        for (ZHMusicInfo *musicInfo in musics) {
//            MPMediaItem *song = [NSKeyedUnarchiver unarchiveObjectWithData:musicInfo.data];
//            [_allMusic addObject:song];
//        }
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            complation();
//        });
//    });
    
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
    header.backgroundColor = [UIColor whiteColor];
    
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
