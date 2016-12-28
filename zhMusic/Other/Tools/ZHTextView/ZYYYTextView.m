//
//  ZYYYTextView.m
//  ZYNaNian
//
//  Created by 张淏 on 16/8/24.
//  Copyright © 2016年 ZYNaNian. All rights reserved.
//

#import "ZYYYTextView.h"
#import "Header.h"


typedef void(^doneClick)(NSString *text);
@interface ZYYYTextView ()


@property (nonatomic, copy) doneClick click;
@end

@implementation ZYYYTextView {
    NSInteger wordMaxNum;
}


- (YYTextView *)textView {
    if (_textView == nil) {
        _textView = [[YYTextView alloc] init];
        
        _textView.frame = CGRectMake(9, 8, self.width - 40 - 12 * 2 - 9, self.height - 8 * 2);
        // 40 “确定“ 按钮的宽
        // 9 leftMargin
        // 12 ”确定“ 按钮两边的间距
        
        _textView.placeholderText = @"请输入文字...";
        _textView.placeholderFont = [UIFont systemFontOfSize:14];
        _textView.font = [UIFont systemFontOfSize:14];
        
        _textView.keyboardType = self.keyboardType ? self.keyboardType : UIKeyboardAppearanceDefault;
        _textView.returnKeyType = self.returnKeyType ? self.returnKeyType : UIReturnKeyDone;

        _textView.delegate = self;
        
        _textView.layer.borderWidth = 0.5;
        _textView.layer.borderColor = ZHRGBColor(229, 229, 229).CGColor;
    }
    return _textView;
}
- (void)textViewDidChange:(YYTextView *)textView {

    NSString *nsTextContent = textView.text;
    NSInteger existTextNum = nsTextContent.length;
    
    
    if (existTextNum > wordMaxNum) {
        NSString *s = [nsTextContent substringToIndex:wordMaxNum];
        textView.text = s;
    }
    
    NSString *tempStr = textView.text;
    if ([tempStr rangeOfString:@"\n"].location != NSNotFound) {
        NSArray *tempArr = [tempStr componentsSeparatedByString:@"\n"];
        textView.text = [tempArr firstObject];
        
        NSLog(@"不能换行哦>_<");
    }

}
- (BOOL)textView:(YYTextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    UITextRange *selectedRange = [textView markedTextRange];
    
    UITextPosition *pos = [textView positionFromPosition:selectedRange.start offset:0];
    if (selectedRange && pos) {
        NSInteger startOffset = [textView offsetFromPosition:textView.beginningOfDocument toPosition:selectedRange.start];
        NSInteger endOffset = [textView offsetFromPosition:textView.beginningOfDocument toPosition:selectedRange.end];
        NSRange offRange = NSMakeRange(startOffset, endOffset - startOffset);
        if (offRange.location < wordMaxNum) {
            return YES;
        } else {
            return NO;
        }
    }
    
    while ((range.location + range.length) > textView.text.length) {
        range.length -= 1;
    }
    
    NSString *comcatstr = [textView.text stringByReplacingCharactersInRange:range withString:text];
    NSInteger caninputlen = wordMaxNum - comcatstr.length;
    
    
    if (caninputlen >= 0) {
        return YES;
    } else {
        NSInteger len = text.length + caninputlen;
        NSRange rg = {0, MAX(len, 0)};
        if (rg.length > 0) {
            NSString *s = @"";
            BOOL asc = [text canBeConvertedToEncoding:NSASCIIStringEncoding];
            if (asc) {
                s = [text substringWithRange:rg];
            } else {
                __block NSInteger idx = 0;
                __block NSString *trimString = @"";
                [text enumerateSubstringsInRange:NSMakeRange(0, [text length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                    if (idx >= rg.length) {
                        *stop = YES;
                        return ;
                    }
                    trimString = [trimString stringByAppendingString:substring];
                    idx++;
                }];
                s = trimString;
            }
            [textView setText:[textView.text stringByReplacingCharactersInRange:range withString:s]];
        }
        return NO;
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    NSLog(@"ZYYYTextViewDealloc");
}
+ (instancetype)zyTextViewWithWordNum:(NSInteger)wordNum frame:(CGRect)frame doneClick:(void (^)(NSString *text))doneClick {
    ZYYYTextView *container = [[ZYYYTextView alloc] initWithFrame:frame];

    container->wordMaxNum = wordNum;
    container.backgroundColor = [UIColor whiteColor];
    
    container.layer.borderColor = ZHRGBColor(229, 229, 299).CGColor;
    container.layer.borderWidth = 0.5;
    
    [container addSubview:container.textView];
    
    if (wordNum != NSIntegerMax) {
        
        UILabel *lbl = [[UILabel alloc] init];
        lbl.text = [NSString stringWithFormat:@"最多输入%ld个字", wordNum];
        lbl.font = [UIFont systemFontOfSize:10];
        lbl.textColor = [UIColor grayColor];
        [lbl sizeToFit];
        
        lbl.origin = CGPointMake(CGRectGetMaxX(container.textView.frame) - 6 - lbl.width, CGRectGetMaxY(container.textView.frame) - lbl.height - 6);
        
        [container addSubview:lbl];
    }
    
    
    UIButton *done = [[UIButton alloc] init];
    
    done.width = 50;
    done.height = 30;
    done.x = container.width - 10 - done.width;
    done.y = (container.height - done.height) * 0.5;
    
    done.titleLabel.font = [UIFont systemFontOfSize:14];
    done.layer.cornerRadius = 5;
    done.layer.masksToBounds = YES;
    done.layer.borderColor = ZHRGBColor(229, 229, 229).CGColor;
    done.layer.borderWidth = 1;
    
    [done setTitle:@"确定" forState:UIControlStateNormal];
    [done setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [done addTarget:container action:@selector(doneClick) forControlEvents:UIControlEventTouchUpInside];
    [container addSubview:done];
    
    // 1.显示键盘
    [[NSNotificationCenter defaultCenter] addObserver:container selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    // 2.隐藏键盘
    [[NSNotificationCenter defaultCenter] addObserver:container selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    container.click = doneClick;
    return container;
}
- (void)doneClick {
    if (self.click) {
        self.click(_textView.text);
    }
}


- (void)keyboardWillShow:(NSNotification *)note
{
    // 1.登录按钮最下面的Y值
    //    CGFloat maxY = CGRectGetMaxY(self.bgView.frame);
    
    // 2.计算键盘的Y值
    // 2.1.取出键盘的高度
    CGFloat keyboardH = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    // 2.2.控制器view的高度 - 键盘的高度
    CGFloat keyboardY = ZHMainScreenH - keyboardH;
    if (self.viewH) {
        keyboardY = _viewH - keyboardH;
    }
    
    // 3.比较 文本框最大Y 跟 键盘Y
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    if (duration <= 0.0) {
        duration = 0.25;
    }
    
    NSLog(@"keyboardYkeyboardY:%f, %f", keyboardY, self.height);
    
    [UIView animateWithDuration:duration animations:^{
        self.y = keyboardY - self.height;
    }];
}

#pragma mark 隐藏键盘就会调用
- (void)keyboardWillHide:(NSNotification *)note
{
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.y = ZHMainScreenH;
    }];
}

@end
