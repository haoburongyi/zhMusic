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
    BOOL _isEdit;
}

- (void)setText:(NSString *)text {
    _text = text;
//    self.textLabel.text = text;
    _textLbl.text = text;
    [_textLbl sizeToFit];
    [UIView animateWithDuration:0.25 animations:^{
        _textLbl.origin = CGPointMake(_isEdit ? 40 : 15, self.contentView.height * 0.5 - _textLbl.height * 0.5);
    }];
}

+ (instancetype)musicCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath identifier:(NSString *)identifier isEdit:(BOOL)isEdit {
    ZHMusicCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[ZHMusicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell configureTextLbl];
//        cell.textLabel.textColor = ZHRedColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    cell->_isEdit = isEdit;
    return cell;
}

- (void)configureTextLbl {
    
    _textLbl = [UILabel new];
    _textLbl.textColor = ZHRedColor;
    [self.contentView addSubview:_textLbl];
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
