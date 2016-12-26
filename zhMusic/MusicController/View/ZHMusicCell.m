//
//  ZHMusicCell.m
//  zhMusic
//
//  Created by 张淏 on 16/12/21.
//  Copyright © 2016年 张淏. All rights reserved.
//

#import "ZHMusicCell.h"
#import "Header.h"

@implementation ZHMusicCell {
    UILabel *_textLbl;
}

//- (void)setText:(NSString *)text {
//    _text = text;
//    self.textLabel.text = text;
//    _textLbl.text = text;
//    [_textLbl sizeToFit];

//}

+ (instancetype)musicCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath identifier:(NSString *)identifier {
    ZHMusicCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[ZHMusicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        [cell configureTextLbl];
        cell.textLabel.textColor = ZHRedColor;
        cell.textLabel.font = [UIFont systemFontOfSize:18];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    return cell;
}

//- (void)configureTextLbl {
//    
//    _textLbl = [UILabel new];
//    _textLbl.textColor = ZHRedColor;
//    [self.contentView addSubview:_textLbl];
//}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
