//
//  ZHMusicVC.m
//  zhMusic
//
//  Created by 张淏 on 16/12/21.
//  Copyright © 2016年 张淏. All rights reserved.
//

#import "ZHMusicVC.h"
#import "ZHMusicVCUIService.h"
#import "ZHMusicViewModel.h"

@interface ZHMusicVC ()

@end

@implementation ZHMusicVC {
    UITableView *_tableView;
    ZHMusicVCUIService *_serivce;
    ZHMusicViewModel *_viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _serivce = [ZHMusicVCUIService new];
    _viewModel = [ZHMusicViewModel new];
    
    [self configurationTableView];
    [_viewModel loadDataCompletion:^(NSArray *list) {
        NSLog(@"%@", list);
        [_tableView reloadData];
    }];
}

- (void)configurationTableView {
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    _tableView.delegate = _serivce;
    _tableView.dataSource = _serivce;
    
    [self.view addSubview:_tableView];
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
