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

@interface ZHAllMusicVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ZHAllMusicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self configureTableView];
    [self loadAllMusic];
}
- (void)configureTableView {
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    UIView *header = [self createHeader];
    
    
    [self.view addSubview:_tableView];
}
- (UIView *)createHeader {
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 40)];
    
    UILabel *shuffleAll = [UILabel new];
    shuffleAll.text = @"随机播放";
//    shuffleAll
    
    return header;
}

- (void)loadAllMusic {
//    [NSKeyedArchiver archivedDataWithRootObject:song];
    RLMResults *musics = [ZHMusicInfo allObjects];
    for (ZHMusicInfo *musicInfo in musics) {
        MPMediaItem *song = [NSKeyedUnarchiver unarchiveObjectWithData:musicInfo.data];
        NSLog(@"%@", song.title);
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return nil;
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
