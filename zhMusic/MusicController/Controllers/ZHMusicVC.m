//
//  ZHMusicVC.m
//  zhMusic
//
//  Created by 张淏 on 16/12/21.
//  Copyright © 2016年 张淏. All rights reserved.
//

#import "ZHMusicVC.h"
#import <UINavigationController+FDFullscreenPopGesture.h>
#import "Header.h"
#import "ZHMusicViewModel.h"
#import "ZHMusicHeader.h"
#import "ZHMusicCell.h"
#import "ZYYYTextView.h"
#import "ZHAllMusicVC.h"



@interface ZHMusicVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) ZHMusicViewModel *viewModel;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *library;
@property (nonatomic, strong) UIView *footer;
@property (nonatomic, strong) ZYYYTextView *textView;
    
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
            if ([weakSelf.library containsObject:text]) {
                [weakSelf showAlert];
            } else {
                [weakSelf addRow:text];
            }
            [weakSelf.view endEditing:YES];
        }];
        [self.view addSubview:_textView];
    }
    return _textView;
}
- (void)showAlert {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"警告" message:@"已有该名称分组, 添加失败" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *done = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil];
    [alertVC addAction:done];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)addRow:(NSString *)text {
    [_library addObject:text];
    [UIView animateWithDuration:0.25 animations:^{
        self.footer.y += 44;
    }];
    self.textView.textView.text = nil;
    [_tableView reloadData];
}

- (void)intPutNewGroupName {
    UIView *cover = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UITapGestureRecognizer *close = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEdit:)];
    [cover addGestureRecognizer:close];
    [self.view addSubview:cover];
    [self.textView.textView becomeFirstResponder];
    [self.view bringSubviewToFront:self.textView];
}
- (void)endEdit:(UITapGestureRecognizer *)tap {
    [tap.view removeFromSuperview];
    [self.view endEditing:YES];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [ZHPlayMusicManager shareManage];
    self.fd_prefersNavigationBarHidden = YES;
    
    _viewModel = [ZHMusicViewModel new];
    _library = [NSMutableArray array];
    
    [self configurationTableView];
    [_viewModel loadDataCompletion:^(NSArray *library) {
        [_library addObjectsFromArray:library];
        [_tableView reloadData];
    }];
}

- (void)configurationTableView {
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    
    // 自定义 header
    ZHMusicHeader *header = [[ZHMusicHeader alloc] initWithFrame:CGRectMake(0, -86, self.view.width, 86)];
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
        self.footer.y = 44 * _library.count + self.footer.height;
        [_tableView addSubview:self.footer];
    } else {
        [[NSUserDefaults standardUserDefaults] setObject:_library.copy forKey:MusicListKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self.footer removeFromSuperview];
    }
}

#pragma - mark tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _library.count;
}

static NSString *musicCellID = @"musicCellID";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZHMusicCell *cell = [ZHMusicCell musicCellWithTableView:tableView indexPath:indexPath identifier:musicCellID];
    
    if (indexPath.row != _library.count) {
        
        cell.textLabel.text = _library[indexPath.row];
    } else {
        cell.textLabel.text = @"add";
    }
    
    
    return cell;
}

#pragma - mark tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *title = _library[indexPath.row];
    
    // swift 能 switch 字符串真的方便好多 - -~!
    if ([title isEqualToString:@"全部歌曲"]) {
        ZHAllMusicVC *vc = [[ZHAllMusicVC alloc] init];
        vc.title = title;
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([title isEqualToString:@"表演者"]) {
        
    } else if ([title isEqualToString:@"专辑"]) {
        
    } else {
        
    }
    
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleDelete;
}

// 进入编辑模式，确定编辑提交操作时，执行的代理方法
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_library removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [UIView animateWithDuration:0.25 animations:^{
            self.footer.y -= 44;
        }];
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    // 实现数据源的排序操作
    [_library exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
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
