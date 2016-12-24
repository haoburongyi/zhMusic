//
//  ZYYYTextView.h
//  ZYNaNian
//
//  Created by 张淏 on 16/8/24.
//  Copyright © 2016年 ZYNaNian. All rights reserved.
//

#import <YYTextView.h>

@interface ZYYYTextView : UIView<YYTextViewDelegate>

@property (nonatomic, strong)YYTextView *textView;
@property (nonatomic, assign)CGFloat viewH;
@property (nonatomic, assign)UIKeyboardType keyboardType;
@property (nonatomic, assign)UIReturnKeyType returnKeyType;

/**
 注:
 
 @param wordNum if unlimited input NSIntegerMax
 @param frame frame
 @param doneClick 回调
 @return self
 */
+ (instancetype)zyTextViewWithWordNum:(NSInteger)wordNum frame:(CGRect)frame doneClick:(void (^)(NSString *text))doneClick;
@end
