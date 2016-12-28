//
//  ZHAllMusicCell.m
//  zhMusic
//
//  Created by 张淏 on 16/12/28.
//  Copyright © 2016年 张淏. All rights reserved.
//

#import "ZHAllMusicCell.h"
#import "Header.h"

@implementation ZHAllMusicCell

+ (instancetype)allMusicCellWithTableView:(UITableView *)tableView identifier:(NSString *)identifier indexPath:(NSIndexPath *)indexPath {
    ZHAllMusicCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[ZHAllMusicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell createUI];
    }
    
    return cell;
}
- (void)createUI {
    
    CGFloat topMargin = 4;
    _artworkImg = [[UIImageView alloc] initWithFrame:CGRectMake(20, topMargin, self.contentView.height - topMargin * 2, self.contentView.height - topMargin * 2)];
    [self.contentView addSubview:_artworkImg];
    
    CGFloat lblMargin = 12;
    CGFloat lblLeftMargin = self.separatorInset.left;
    CGFloat lblWidth = self.contentView.width - CGRectGetMaxX(_artworkImg.frame) - lblLeftMargin;

    _songNameLbl = [[UILabel alloc] init];
    _songNameLbl.text = @"歌曲名";
    _songNameLbl.font = [UIFont systemFontOfSize:14];
    CGSize songNameSize = [_songNameLbl.text sizeWithAttributes:@{
                                                                  NSFontAttributeName: _songNameLbl.font}
                           ];
    _songNameLbl.frame = CGRectMake(CGRectGetMaxX(_artworkImg.frame) + lblLeftMargin, lblMargin, lblWidth, songNameSize.height);
    
    [self.contentView addSubview:_songNameLbl];
    
    
    _singerLbl = [[UILabel alloc] init];
    _singerLbl.font = [UIFont systemFontOfSize:12];
    _singerLbl.textColor = ZHRGBColor(200, 200, 200);
    _singerLbl.text = @"演唱者";
    
    CGSize singerSize = [@"演唱者" sizeWithAttributes: @{
                                                       NSFontAttributeName : _singerLbl.font
                                                       }];
    _singerLbl.frame = CGRectMake(_songNameLbl.x, self.contentView.height - singerSize.height, lblWidth, singerSize.height);
    [self.contentView addSubview:_singerLbl];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
