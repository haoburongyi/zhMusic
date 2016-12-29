//
//  ZHAllMusicCell.m
//  zhMusic
//
//  Created by 张淏 on 16/12/28.
//  Copyright © 2016年 张淏. All rights reserved.
//

#import "ZHAllMusicCell.h"
#import "Header.h"
#import "UIImage+Extension.h"

@interface ZHAllMusicCell ()
@property (nonatomic, strong) UIImageView *artworkImg;  // 专辑图
@end

@implementation ZHAllMusicCell

- (void)setImage:(UIImage *)image {
    _image = image;
    
    [image zh_cornerImageWithSize:_artworkImg.size cornerRadius:4 fillColor:[UIColor whiteColor] completion:^(UIImage *image) {
        _artworkImg.image = image;
    }];
}

+ (instancetype)allMusicCellWithTableView:(UITableView *)tableView identifier:(NSString *)identifier indexPath:(NSIndexPath *)indexPath rowHeight:(CGFloat)rowHeight {
    ZHAllMusicCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[ZHAllMusicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell createUIWithRowHeight:rowHeight];
    }
    
    return cell;
}
- (void)createUIWithRowHeight:(CGFloat)rowHeight {
    
    CGFloat topMargin = 4;
    
    _artworkImg = [[UIImageView alloc] initWithFrame:CGRectMake(20, topMargin, rowHeight - topMargin * 2, rowHeight - topMargin * 2)];
    _artworkImg.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:_artworkImg];
    
    CGFloat lblTopMargin = 10;
    CGFloat lblLeftMargin = self.separatorInset.left;
    CGFloat lblWidth = self.contentView.width - CGRectGetMaxX(_artworkImg.frame) - lblLeftMargin;

    _songNameLbl = [[UILabel alloc] init];
    _songNameLbl.text = @"歌曲名";
    _songNameLbl.font = [UIFont systemFontOfSize:12];
    CGSize songNameSize = [_songNameLbl.text sizeWithAttributes:@{
                                                                  NSFontAttributeName: _songNameLbl.font}
                           ];
    _songNameLbl.frame = CGRectMake(CGRectGetMaxX(_artworkImg.frame) + lblLeftMargin, lblTopMargin, lblWidth, songNameSize.height);
    
    [self.contentView addSubview:_songNameLbl];
    
    
    _singerLbl = [[UILabel alloc] init];
    _singerLbl.font = [UIFont systemFontOfSize:11];
    _singerLbl.textColor = ZHRGBColor(200, 200, 200);
    _singerLbl.text = @"演唱者";
    CGSize singerSize = [_singerLbl.text sizeWithAttributes: @{
                                                       NSFontAttributeName : _singerLbl.font
                                                       }];
    _singerLbl.frame = CGRectMake(_songNameLbl.x, rowHeight - singerSize.height - lblTopMargin + 2, lblWidth, singerSize.height);
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
