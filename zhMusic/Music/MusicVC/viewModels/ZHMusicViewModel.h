//
//  ZHMusicViewModel.h
//  zhMusic
//
//  Created by 张淏 on 16/12/21.
//  Copyright © 2016年 张淏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHMusicViewModel : NSObject
- (void)loadDataCompletion:(void(^)(NSArray *library))completion;
@end
