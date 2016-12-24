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
#import "ZYYYTextView.h"



@interface ZHMusicVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)ZHMusicViewModel *viewModel;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *list;
@property (nonatomic, strong)UIView *footer;
@property (nonatomic, strong)ZYYYTextView *textView;
    
@end

@implementation ZHMusicVC

- (UIView *)footer {
    if (!_footer) {
        _footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 44)];
        UIButton *add = [UIButton buttonWithType:UIButtonTypeContactAdd];
        add.size = _footer.size;
        [_footer addSubview:add];
        [add addTarget:self action:@selector(intPutNewGroupName) forControlEvents:UIControlEventTouchUpInside];
        add.tintColor = ZHRedColor;
    }
    return _footer;
}

- (ZYYYTextView *)textView {
    if (_textView == nil) {
        __weak typeof(self) weakSelf = self;
        _textView = [ZYYYTextView zyTextViewWithWordNum:8 frame:CGRectMake(0, self.view.height, self.view.width, ZHSCaleH(56)) doneClick:^(NSString *text) {
            [weakSelf addRow:text];
            [weakSelf.view endEditing:YES];
        }];
        [self.view addSubview:_textView];
    }
    return _textView;
}

- (void)addRow:(NSString *)text {
    
}

- (void)intPutNewGroupName {
    NSLog(@"%s", __FUNCTION__);
    [self.textView.textView becomeFirstResponder];
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
    
    // 自定义 header
    ZHMusicHeader *header = [[ZHMusicHeader alloc] initWithFrame:CGRectMake(0, 0, self.view.width, ZHSCaleH(33))];
    __weak typeof(self) weakSelf = self;
    header.editClick = ^(UIButton *sender) {
        [weakSelf editList:sender];
    };
    [_tableView addSubview:header];
    
    _tableView.tableFooterView = [UIView new];
    
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.contentInset = UIEdgeInsetsMake(header.height, 0, 0, 0);
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
}

- (void)editList:(UIButton *)sender {
    
    [_tableView setEditing:sender.selected animated:YES];

    if (sender.selected) {
        // 自定义 footer
        self.footer.y = 44 * _list.count + self.footer.height;
        [_tableView addSubview:self.footer];
    } else {
        [self.footer removeFromSuperview];
    }
}

#pragma - mark tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _list.count;
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

#pragma - mark tableViewDelegate
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return indexPath.row != _list.count ? UITableViewCellEditingStyleDelete : UITableViewCellEditingStyleInsert;
}

// 进入编辑模式，确定编辑提交操作时，执行的代理方法
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    // 实现数据源的排序操作
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
