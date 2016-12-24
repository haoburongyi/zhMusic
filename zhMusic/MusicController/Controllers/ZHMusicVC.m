//
//  ZHMusicVC.m
//  zhMusic
//
//  Created by 张淏 on 16/12/21.
//  Copyright © 2016年 张淏. All rights reserved.
//

#import "ZHMusicVC.h"
#import "Header.h"
#import "ZHMusicViewModel.h"
#import "ZHMusicHeader.h"
#import "ZHMusicCell.h"

@interface ZHMusicVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)ZHMusicViewModel *viewModel;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *list;
@property (nonatomic, assign)NSInteger editCount;
@property (nonatomic, strong)UIView *footer;
@end

@implementation ZHMusicVC {
    BOOL _isEdit;
}

- (NSInteger)editCount {
    return _isEdit ? 1 : 0;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBarHidden = YES;
    
    _viewModel = [ZHMusicViewModel new];
    _list = [NSMutableArray array];
    
    [self configurationTableView];
    [_viewModel loadDataCompletion:^(NSArray *list) {
        [_list addObjectsFromArray:list];
        [_tableView reloadData];
    }];
}

- (void)configurationTableView {
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    
    ZHMusicHeader *header = [[ZHMusicHeader alloc] initWithFrame:CGRectMake(0, 0, self.view.width, ZHSCaleH(33))];
    __weak typeof(self) weakSelf = self;
    header.editClick = ^(UIButton *sender) {
        [weakSelf editList:sender];
    };
    [_tableView addSubview:header];
    
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.contentInset = UIEdgeInsetsMake(header.height, 0, 0, 0);
    _tableView.tableFooterView = [UIView new];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
}

- (void)editList:(UIButton *)sender {
    
    _isEdit = sender.selected;
    // 分割线动画
//    [UIView animateWithDuration:0.25 animations:^{
//        if (sender.selected) {
//            _tableView.separatorInset = UIEdgeInsetsMake(0, 55, 0, 0);
//        } else {
//            _tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
//        }
//    }];
    
    [_tableView setEditing:sender.selected animated:YES];
    if (sender.selected) {
        
        [_tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_list.count inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    } else {
        [_tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_list.count inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    }
}


/// tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _list.count + self.editCount;
}

static NSString *musicCellID = @"musicCellID";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZHMusicCell *cell = [ZHMusicCell musicCellWithTableView:tableView indexPath:indexPath identifier:musicCellID];
    
    if (indexPath.row != _list.count) {
        
        cell.textLabel.text = _list[indexPath.row];
    } else {
        cell.textLabel.text = @"add";
    }
    
    
    return cell;
}

// tableViewDelegate
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return indexPath.row != _list.count ? UITableViewCellEditingStyleDelete : UITableViewCellEditingStyleInsert;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    // 这里什么都没有实现
    // 正常的话，应该在这里实现数据源的排序操作
    if (sourceIndexPath.row == _list.count) {
        
    }
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
