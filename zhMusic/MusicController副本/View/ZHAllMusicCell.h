//
//  ZHAllMusicCell.h
//  zhMusic
//
//  Created by 张淏 on 16/12/28.
//  Copyright © 2016年 张淏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHAllMusicCell : UITableViewCell

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImageView *artworkImg;  // 专辑图
@property (nonatomic, strong) UILabel *songNameLbl;     // 歌曲名
@property (nonatomic, strong) UILabel *singerLbl;       // 歌手

+ (instancetype)allMusicCellWithTableView:(UITableView *)tableView identifier:(NSString *)identifier indexPath:(NSIndexPath *)indexPath rowHeight:(CGFloat)rowHeight;
@end
