//
//  ZHPlayVCUISercive.m
//  zhMusic
//
//  Created by 张淏 on 17/1/1.
//  Copyright © 2017年 张淏. All rights reserved.
//

#import "ZHPlayVCUISercive.h"
#import "Header.h"
#import "ZHAllMusicCell.h"
#import "UIImage+Extension.h"
#import "ZHPlayVC.h"

#define cellH 55.5

@implementation ZHPlayVCUISercive

- (UITableViewCell *)zeroCell {
    UITableViewCell *zeroCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    zeroCell.textLabel.text = @"接着播放";
    NSLog(@"%@", zeroCell.textLabel.font);
    zeroCell.textLabel.font = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:17];
    return zeroCell;
}

#pragma mark - tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _playList.count + 1;
}

static NSString *ZHPlayVCCellID = @"ZHPlayVCCellID";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row != 0) {
        ZHAllMusicCell *cell = [ZHAllMusicCell allMusicCellWithTableView:tableView identifier:ZHPlayVCCellID indexPath:indexPath rowHeight:cellH];
        
        MPMediaItem *song = _playList[indexPath.row - 1];
        
        cell.image = [UIImage defaultImageWithSongItem:song size:cell.artworkImg.size];
        cell.songNameLbl.text = [song valueForProperty:MPMediaItemPropertyTitle];
        cell.singerLbl.text = [song valueForProperty:MPMediaItemPropertyArtist];
        return cell;
    } else {
        return [self zeroCell];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.row == 0 ? 44 : cellH;
}

#pragma mark - tableViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //    NSLog(@"%f, %f", scrollView.contentOffset.y, scrollView.contentSize.height);
    
    // 下拉距离
    if (scrollView.contentOffset.y < - 80 && scrollView.dragging) {
        [[ZHPlayVC defaultVC] disMiss];
    }
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[ZHPlayVC defaultVC] disMiss];
    });
    return YES;
}

@end
