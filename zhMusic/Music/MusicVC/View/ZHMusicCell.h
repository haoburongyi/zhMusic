//
//  ZHMusicCell.h
//  zhMusic
//
//  Created by 张淏 on 16/12/21.
//  Copyright © 2016年 张淏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHMusicCell : UITableViewCell

+ (instancetype)musicCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath identifier:(NSString *)identifier;
@end