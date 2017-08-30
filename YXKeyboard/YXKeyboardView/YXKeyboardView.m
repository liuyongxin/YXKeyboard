//
//  YXKeyboardView.m
//  YXKeyboard
//
//  Created by DZH_Louis on 2017/8/25.
//  Copyright © 2017年 Louis. All rights reserved.
//

#import "YXKeyboardView.h"

struct keyPadLocation {
    float xPos;
    float yPos;
    float xPadding;
    float yPadding;
    float width;
    float heigth;
    float font;
};

struct keyPadLocation typeOfNumberLocation  = {
    .xPos = 3,
    .yPos = 7,
    .xPadding = 5,
    .yPadding = 5,
    .width = 60,
    .heigth = 50,
    .font = 20,
};

struct keyPadLocation typeOfLetterLocation  = {
    .xPos = 3,
    .yPos = 7,
    .xPadding = 5,
    .yPadding = 15,
    .width = 60,
    .heigth = 50,
    .font = 20,
};

struct keyPadLocation typeOfSymbolLocation  = {
    .xPos = 3,
    .yPos = 7,
    .xPadding = 5,
    .yPadding = 15,
    .width = 60,
    .heigth = 50,
    .font = 20,
};

@interface YXKeyboardView ()

@property(nonatomic,retain)NSMutableArray *btnsArr;

@end

@implementation YXKeyboardView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.type = YXKeyboardTypeOfNumber;
        self.backgroundColor = UIColor.orangeColor;
        _btnsArr = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)bindFirstResponder:(UIResponder *)responder
{
    _firstResponder = responder;
    if (_firstResponder) {
        if ([_firstResponder isKindOfClass:[UITextField class]])
        {
            UITextField *tf = (UITextField *)_firstResponder;
            tf.inputView = self;
        }
        else if ([_firstResponder isKindOfClass:[UITextView class]])
        {
            UITextView *tv = (UITextView *)_firstResponder;
            tv.inputView = self;
        }
    }
}

- (NSArray *)keyboardDisplayText:(YXKeyboardType )type
{
    if (type == YXKeyboardTypeOfNumber) //数字
    {
        return @[@"1",@"2",@"3",@"del",@"4",@"5",@"6",@"7",@"8",@"9",@"确定",@"ABC",@"0",@"#+="];
    }
    else if (type == YXKeyboardTypeOfLowercaseLetter) //小写字母
    {
        return @[@"q",@"w",@"e",@"r",@"t",@"y",@"u",@"i",@"o",@"p",
                 @"a",@"s",@"d",@"f",@"g",@"h",@"j",@"k",@"l",
                 @"Tab",@"z",@"x",@"c",@"v",@"b",@"n",@"m",@"del",
                 @"123",@"#+=",@"space",@"确定"];
    }
    else if (type == YXKeyboardTypeOfUppercaseLetter) //大写字母
    {
        return @[@"Q",@"W",@"E",@"R",@"T",@"Y",@"U",@"I",@"O",@"P",
                 @"A",@"S",@"D",@"F",@"G",@"H",@"J",@"K",@"L",
                 @"Tab",@"Z",@"X",@"C",@"V",@"B",@"N",@"M",@"del",
                 @"123",@"#+=",@"space",@"确定"];
    }
    else if (type == YXKeyboardTypeOfSymbol) //符号
    {
        return @[@"!",@"@",@"#",@"$",@"%",@"^",@"&",@"*",@"(",@")",
                 @"'",@"\"",@"=",@"_",@"`",@":",@";",@"?",@"~",@"|",
                 @"+",@"-",@"\\",@"/",@"[",@"]",@"{",@"}",@"del",
                 @"123",@"ABC",@",",@".",@"<",@">",@"确定"];
    }
    return nil;
}

- (void)drawKeyboardTypeOfNumberRect:(CGRect)rect
{
    [self.btnsArr removeAllObjects];
    NSArray *keypadTextArr = [self keyboardDisplayText:_type];
    CGFloat deleteAndConfirmWidth = 60;
    typeOfNumberLocation.width = (self.frame.size.width - typeOfNumberLocation.xPos *2 - typeOfNumberLocation.xPadding*3 - deleteAndConfirmWidth)/3;
    typeOfNumberLocation.heigth = (self.frame.size.height - typeOfNumberLocation.yPos - typeOfNumberLocation.yPadding *4)/4;
    int   n = 0;
    for (int i = 0; i < keypadTextArr.count; i++) {
        NSString *text = keypadTextArr[i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:typeOfNumberLocation.font];
        [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        if ([text isEqualToString:@"del"]) {
            [btn setTitle:@"<==" forState:UIControlStateNormal];
            [btn setBackgroundColor:UIColor.whiteColor];
            btn.frame =  (CGRect){
                typeOfNumberLocation.xPos + (typeOfNumberLocation.width + typeOfNumberLocation.xPadding)*3,
                typeOfNumberLocation.yPos ,
                deleteAndConfirmWidth,
                typeOfNumberLocation.heigth * 2 + typeOfNumberLocation.yPadding
            };
            [btn addTarget:self action:@selector(deleteLetterOrNumber:) forControlEvents:UIControlEventTouchUpInside];
        }
        else if ([text isEqualToString:@"确定"])
        {
            [btn setTitle:@"确定" forState:UIControlStateNormal];
            [btn setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
            [btn setBackgroundColor:UIColor.grayColor];
            btn.frame =  (CGRect){
                typeOfNumberLocation.xPos + (typeOfNumberLocation.width + typeOfNumberLocation.xPadding)*3,
                typeOfNumberLocation.yPos + typeOfNumberLocation.heigth*2 + typeOfNumberLocation.yPadding*2,
                deleteAndConfirmWidth,
                typeOfNumberLocation.heigth * 2 + typeOfNumberLocation.yPadding
            };
            [btn addTarget:self action:@selector(confirmOrWrap:) forControlEvents:UIControlEventTouchUpInside];
        }
        else
        {
            int xOffset = n % 3;
            int yOffset = n / 3;
            [btn setTitle:text forState:UIControlStateNormal];
            btn.frame =  (CGRect){
                typeOfNumberLocation.xPos + (typeOfNumberLocation.width + typeOfNumberLocation.xPadding)*xOffset,
                typeOfNumberLocation.yPos + (typeOfNumberLocation.heigth + typeOfNumberLocation.yPadding)*yOffset,
                typeOfNumberLocation.width,
                typeOfNumberLocation.heigth
            };
            if ([text isEqualToString:@"ABC"] || [text isEqualToString:@"#+="])
            {
                [btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
                [btn setBackgroundColor:UIColor.grayColor];
                [btn addTarget:self action:@selector(changeKeyboardTypeAction:) forControlEvents:UIControlEventTouchUpInside];
            }
            else
            {
                btn.userInteractionEnabled = NO;
                [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
                [btn setTitleColor:UIColor.grayColor forState:UIControlStateHighlighted];
                [btn setBackgroundColor:UIColor.whiteColor];
            }
            n++;
        }
        [self addSubview:btn];
        [self.btnsArr addObject:btn];
    }
}

- (void)drawKeyboardTypeOfLetterRect:(CGRect)rect
{
    [self.btnsArr removeAllObjects];
    NSArray *keypadTextArr = [self keyboardDisplayText:_type];
    typeOfLetterLocation.heigth = (self.frame.size.height - typeOfLetterLocation.yPos *2 - typeOfLetterLocation.yPadding *3)/4;
    typeOfLetterLocation.width = (self.frame.size.width - typeOfLetterLocation.xPos *2 - typeOfLetterLocation.xPadding*9)/10;
    int  n = 0;
    for (int i = 0; i < keypadTextArr.count; i++) {
        NSString *text = keypadTextArr[i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:typeOfLetterLocation.font];
        [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        if (i >= 0 && i < 10) {
            n = i;
            [btn setTitle:text forState:UIControlStateNormal];
            btn.userInteractionEnabled = NO;
            [btn setTitleColor:UIColor.grayColor forState:UIControlStateHighlighted];
            [btn setBackgroundColor:UIColor.whiteColor];
            btn.frame =  (CGRect){
                typeOfLetterLocation.xPos + (typeOfLetterLocation.width + typeOfLetterLocation.xPadding)*n,
                typeOfLetterLocation.yPos,
                typeOfLetterLocation.width,
                typeOfLetterLocation.heigth
            };
        }
        else if (i >= 10 && i < 19)
        {
            n = i - 10;
            [btn setTitle:text forState:UIControlStateNormal];
            btn.userInteractionEnabled = NO;
            [btn setTitleColor:UIColor.grayColor forState:UIControlStateHighlighted];
            [btn setBackgroundColor:UIColor.whiteColor];
            btn.frame =  (CGRect){
                typeOfLetterLocation.xPos + typeOfLetterLocation.width/2  + (typeOfLetterLocation.width + typeOfLetterLocation.xPadding)*n,
                typeOfLetterLocation.yPos + (typeOfLetterLocation.heigth + typeOfLetterLocation.yPadding),
                typeOfLetterLocation.width,
                typeOfLetterLocation.heigth
            };
        }
        else if (i >= 19 && i < 28)
        {
            n =  i - 19;
            if ([text isEqualToString:@"Tab"]) {
                [btn setTitle:@"Tab" forState:UIControlStateNormal];
                [btn setBackgroundColor:UIColor.whiteColor];
                btn.frame =  (CGRect){
                    typeOfLetterLocation.xPos + (typeOfLetterLocation.width + typeOfLetterLocation.xPadding)*n,
                    typeOfLetterLocation.yPos + (typeOfLetterLocation.heigth + typeOfLetterLocation.yPadding)*2,
                    typeOfLetterLocation.width + typeOfLetterLocation.width/2,
                    typeOfLetterLocation.heigth
                };
                [btn addTarget:self action:@selector(changeKeyboardTypeAction:) forControlEvents:UIControlEventTouchUpInside];
            }
            else if ([text isEqualToString:@"del"])
            {
                [btn setTitle:@"<==" forState:UIControlStateNormal];
                [btn setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
                [btn setBackgroundColor:UIColor.grayColor];
                btn.frame =  (CGRect){
                    typeOfLetterLocation.xPos + typeOfLetterLocation.width/2 + (typeOfLetterLocation.width + typeOfLetterLocation.xPadding)*n,
                    typeOfLetterLocation.yPos + (typeOfLetterLocation.heigth + typeOfLetterLocation.yPadding)*2,
                    typeOfLetterLocation.width + typeOfLetterLocation.width/2 + typeOfLetterLocation.xPadding,
                    typeOfLetterLocation.heigth
                };
                [btn addTarget:self action:@selector(deleteLetterOrNumber:) forControlEvents:UIControlEventTouchUpInside];
            }
            else
            {
                [btn setTitle:text forState:UIControlStateNormal];
                btn.userInteractionEnabled = NO;
                [btn setTitleColor:UIColor.grayColor forState:UIControlStateHighlighted];
                [btn setBackgroundColor:UIColor.whiteColor];
                btn.frame =  (CGRect){
                    typeOfLetterLocation.xPos + typeOfLetterLocation.width/2 + (typeOfLetterLocation.width + typeOfLetterLocation.xPadding)*n,
                    typeOfLetterLocation.yPos + (typeOfLetterLocation.heigth + typeOfLetterLocation.yPadding)*2,
                    typeOfLetterLocation.width,
                    typeOfLetterLocation.heigth
                };
            }
        }
        else if (i >= 28 && i < 32)
        {
            n = i - 28;
            if ([text isEqualToString:@"123"] || [text isEqualToString:@"#+="])
            {
                [btn setTitle:text forState:UIControlStateNormal];
                [btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
                [btn setBackgroundColor:UIColor.grayColor];
                btn.frame =  (CGRect){
                    typeOfLetterLocation.xPos + (typeOfLetterLocation.width*2 + typeOfLetterLocation.xPadding*2)*n,
                    typeOfLetterLocation.yPos + (typeOfLetterLocation.heigth + typeOfLetterLocation.yPadding)*3,
                    typeOfLetterLocation.width*2 + typeOfLetterLocation.xPadding,
                    typeOfLetterLocation.heigth
                };
                [btn addTarget:self action:@selector(changeKeyboardTypeAction:) forControlEvents:UIControlEventTouchUpInside];
            }
            else if ([text isEqualToString:@"space"])
            {
                [btn setTitle:@" " forState:UIControlStateNormal];
                [btn setBackgroundColor:UIColor.grayColor];
                btn.frame =  (CGRect){
                    typeOfLetterLocation.xPos + (typeOfLetterLocation.width*2 + typeOfLetterLocation.xPadding*2)*n,
                    typeOfLetterLocation.yPos + (typeOfLetterLocation.heigth + typeOfLetterLocation.yPadding)*3,
                    typeOfLetterLocation.width*4 + typeOfLetterLocation.xPadding*3,
                    typeOfLetterLocation.heigth
                };
                [btn addTarget:self action:@selector(wirteLetterOrNumber:) forControlEvents:UIControlEventTouchUpInside];
            }
            else if ([text isEqualToString:@"确定"])
            {
                [btn setTitle:@"确定" forState:UIControlStateNormal];
                [btn setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
                [btn setBackgroundColor:UIColor.grayColor];
                btn.frame =  (CGRect){
                    typeOfLetterLocation.xPos + (typeOfLetterLocation.width*4 + typeOfLetterLocation.xPadding*4)*(n- 1),
                    typeOfLetterLocation.yPos + (typeOfLetterLocation.heigth + typeOfLetterLocation.yPadding)*3,
                    typeOfLetterLocation.width*2 + typeOfLetterLocation.xPadding,
                    typeOfLetterLocation.heigth
                };
                [btn addTarget:self action:@selector(confirmOrWrap:) forControlEvents:UIControlEventTouchUpInside];
            }
        }
        [self addSubview:btn];
        [self.btnsArr addObject:btn];
    }
}

- (void)drawKeyboardTypeOfSymbolRect:(CGRect)rect
{
    [self.btnsArr removeAllObjects];
    NSArray *keypadTextArr = [self keyboardDisplayText:_type];
    typeOfSymbolLocation.width = (self.frame.size.width - typeOfSymbolLocation.xPos *2 - typeOfSymbolLocation.xPadding*9)/10;
    typeOfSymbolLocation.heigth = (self.frame.size.height - typeOfSymbolLocation.yPos*2 - typeOfSymbolLocation.yPadding *3)/4;
    int   n = 0;
    for (int i = 0; i < keypadTextArr.count; i++) {
        NSString *text = keypadTextArr[i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:typeOfSymbolLocation.font];
        if (i < 28) {
            n = i;
            int xOffset = n % 10;
            int yOffset = n / 10;
            [btn setTitle:text forState:UIControlStateNormal];
            [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
            [btn setBackgroundColor:UIColor.whiteColor];
            btn.userInteractionEnabled = NO;
            btn.frame =  (CGRect){
                typeOfSymbolLocation.xPos + (typeOfSymbolLocation.width + typeOfSymbolLocation.xPadding)*xOffset,
                typeOfSymbolLocation.yPos + (typeOfSymbolLocation.heigth + typeOfSymbolLocation.yPadding)*yOffset,
                typeOfSymbolLocation.width,
                typeOfSymbolLocation.heigth
            };
        }
        else
        {
            if ([text isEqualToString:@"del"]) {
                [btn setTitle:@"<==" forState:UIControlStateNormal];
                [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
                [btn setBackgroundColor:UIColor.whiteColor];
                btn.frame =  (CGRect){
                    typeOfSymbolLocation.xPos + (typeOfSymbolLocation.width + typeOfSymbolLocation.xPadding)*8,
                    typeOfSymbolLocation.yPos + (typeOfSymbolLocation.heigth + typeOfSymbolLocation.yPadding)*2,
                    typeOfSymbolLocation.width*2 + typeOfSymbolLocation.xPadding,
                    typeOfSymbolLocation.heigth
                };
                [btn addTarget:self action:@selector(deleteLetterOrNumber:) forControlEvents:UIControlEventTouchUpInside];
            }
            else if ([text isEqualToString:@"123"]) {
                [btn setTitle:@"123" forState:UIControlStateNormal];
                [btn setBackgroundColor:UIColor.grayColor];
                btn.frame =  (CGRect){
                    typeOfSymbolLocation.xPos,
                    typeOfSymbolLocation.yPos + (typeOfSymbolLocation.heigth + typeOfSymbolLocation.yPadding)*3,
                    typeOfSymbolLocation.width*2 + typeOfSymbolLocation.xPadding,
                    typeOfSymbolLocation.heigth
                };
                [btn addTarget:self action:@selector(changeKeyboardTypeAction:) forControlEvents:UIControlEventTouchUpInside];
            }
            else if ([text isEqualToString:@"ABC"]) {
                [btn setTitle:@"ABC" forState:UIControlStateNormal];
                [btn setBackgroundColor:UIColor.grayColor];
                btn.frame =  (CGRect){
                    typeOfSymbolLocation.xPos + (typeOfSymbolLocation.width + typeOfSymbolLocation.xPadding)*2,
                    typeOfSymbolLocation.yPos + (typeOfSymbolLocation.heigth + typeOfSymbolLocation.yPadding)*3,
                    typeOfSymbolLocation.width*2 + typeOfSymbolLocation.xPadding,
                    typeOfSymbolLocation.heigth
                };
                [btn addTarget:self action:@selector(changeKeyboardTypeAction:) forControlEvents:UIControlEventTouchUpInside];
            }
            else if ([text isEqualToString:@"确定"])
            {
                [btn setTitle:@"确定" forState:UIControlStateNormal];
                [btn setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
                [btn setBackgroundColor:UIColor.grayColor];
                btn.frame =  (CGRect){
                    typeOfSymbolLocation.xPos + typeOfSymbolLocation.width*8 + typeOfSymbolLocation.xPadding*8,
                    typeOfSymbolLocation.yPos + (typeOfSymbolLocation.heigth + typeOfSymbolLocation.yPadding)*3,
                    typeOfSymbolLocation.width*2 + typeOfSymbolLocation.xPadding,
                    typeOfSymbolLocation.heigth
                };
                [btn addTarget:self action:@selector(confirmOrWrap:) forControlEvents:UIControlEventTouchUpInside];
            }
            else
            {
                n = i - 28 - 2;
                [btn setTitle:text forState:UIControlStateNormal];
                [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
                [btn setBackgroundColor:UIColor.whiteColor];
                btn.userInteractionEnabled = NO;
                btn.frame =  (CGRect){
                    typeOfSymbolLocation.xPos + (typeOfSymbolLocation.width + typeOfSymbolLocation.xPadding)*(n + 3),
                    typeOfSymbolLocation.yPos + (typeOfSymbolLocation.heigth + typeOfSymbolLocation.yPadding)*3,
                    typeOfSymbolLocation.width,
                    typeOfSymbolLocation.heigth
                };
            }
        }
        [self addSubview:btn];
        [self.btnsArr addObject:btn];
    }
}

-(void)wirteLetterOrNumber:(UIButton *)btn
{
    if (_firstResponder)
    {
        if ([_firstResponder isKindOfClass:[UITextField class]])
        {
            UITextField *tf = (UITextField *)_firstResponder;
            [tf replaceRange:tf.selectedTextRange withText:btn.titleLabel.text];
        }
        else if ([_firstResponder isKindOfClass:[UITextView class]])
        {
            UITextView *tv = (UITextView *)_firstResponder;
            [tv replaceRange:tv.selectedTextRange withText:btn.titleLabel.text];
        }
    }
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [self.subviews enumerateObjectsUsingBlock:^(UIView * obj, NSUInteger idx, BOOL *stop) {
        [obj removeFromSuperview];
    }];
    if (_type == YXKeyboardTypeOfNumber) {
        [self drawKeyboardTypeOfNumberRect:rect];
    }
    else  if (_type == YXKeyboardTypeOfLowercaseLetter || _type == YXKeyboardTypeOfUppercaseLetter) {
        [self drawKeyboardTypeOfLetterRect:rect];
    }
    else if (_type == YXKeyboardTypeOfSymbol)
    {
        [self drawKeyboardTypeOfSymbolRect:rect];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    CGPoint location = [touches.anyObject locationInView:self];
    [self touchBeganAndTouchMoveAction:location];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    CGPoint location = [touches.anyObject locationInView:self];
    [self touchBeganAndTouchMoveAction:location];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    CGPoint location = [touches.anyObject locationInView:self];
    [self touchEndedAction:location];
}

- (void)touchBeganAndTouchMoveAction:(CGPoint )location
{
    switch (_type) {
        case YXKeyboardTypeOfNumber:
        {
            for (UIButton *btn in self.btnsArr) {
                if (CGRectContainsPoint(btn.frame, location)) {
                    btn.highlighted = YES;
                }
                else
                {
                    btn.highlighted = NO;
                }
            }
        }
            break;
        case YXKeyboardTypeOfLowercaseLetter:
        {
            for (UIButton *btn in self.btnsArr) {
                if (CGRectContainsPoint(btn.frame, location)) {
                    btn.highlighted = YES;
                }
                else
                {
                    btn.highlighted = NO;
                }
            }
        }
            break;
        case YXKeyboardTypeOfUppercaseLetter:
        {
            for (UIButton *btn in self.btnsArr) {
                if (CGRectContainsPoint(btn.frame, location)) {
                    btn.highlighted = YES;
                }
                else
                {
                    btn.highlighted = NO;
                }
            }
        }
            break;
        case YXKeyboardTypeOfSymbol:
        {
            for (UIButton *btn in self.btnsArr) {
                if (CGRectContainsPoint(btn.frame, location)) {
                    btn.highlighted = YES;
                }
                else
                {
                    btn.highlighted = NO;
                }
            }
        }
            break;
        default:
            break;
    }
}

- (void)touchEndedAction:(CGPoint )location
{
    switch (_type) {
        case YXKeyboardTypeOfNumber:
        {
            for (UIButton *btn in self.btnsArr) {
                if (CGRectContainsPoint(btn.frame, location)) {
                    [self wirteLetterOrNumber:btn];
                }
                btn.highlighted = NO;
            }
        }
            break;
        case YXKeyboardTypeOfLowercaseLetter:
        {
            for (UIButton *btn in self.btnsArr) {
                if (CGRectContainsPoint(btn.frame, location)) {
                    [self wirteLetterOrNumber:btn];
                }
                btn.highlighted = NO;
            }
        }
            break;
        case YXKeyboardTypeOfUppercaseLetter:
        {
            for (UIButton *btn in self.btnsArr) {
                if (CGRectContainsPoint(btn.frame, location)) {
                    [self wirteLetterOrNumber:btn];
                }
                btn.highlighted = NO;
            }
        }
            break;
        case YXKeyboardTypeOfSymbol:
        {
            for (UIButton *btn in self.btnsArr) {
                if (CGRectContainsPoint(btn.frame, location)) {
                    [self wirteLetterOrNumber:btn];
                }
                btn.highlighted = NO;
            }
        }
            break;
        default:
            break;
    }
}

- (void)changeKeyboardTypeAction:(UIButton *)btn //切换键盘类型
{
    if ([btn.titleLabel.text isEqualToString:@"ABC"]) {
        self.type = YXKeyboardTypeOfLowercaseLetter;
    }
    else if ([btn.titleLabel.text isEqualToString:@"#+="])
    {
        self.type = YXKeyboardTypeOfSymbol;
    }
    else if ([btn.titleLabel.text isEqualToString:@"123"])
    {
        self.type = YXKeyboardTypeOfNumber;
    }
    else if ([btn.titleLabel.text isEqualToString:@"Tab"])
    {
        if (self.type == YXKeyboardTypeOfLowercaseLetter)
        {
            self.type = YXKeyboardTypeOfUppercaseLetter;
        }
        else
        {
            self.type = YXKeyboardTypeOfLowercaseLetter;
        }
    }
    [self setNeedsDisplay];
}

-(void)deleteLetterOrNumber:(UIButton *)btn  //删除
{
    if (_firstResponder)
    {
        if ([_firstResponder isKindOfClass:[UITextField class]])
        {
            UITextField *tf = (UITextField *)_firstResponder;
            if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)
            {
                UITextPosition* beginning = tf.beginningOfDocument;
                UITextRange* selectedRange = tf.selectedTextRange;
                UITextPosition* selectionStart = selectedRange.start;
                UITextPosition* selectionEnd = selectedRange.end;
                
                const NSInteger location = [tf offsetFromPosition:beginning toPosition:selectionStart];
                const NSInteger length = [tf offsetFromPosition:selectionStart toPosition:selectionEnd];
                
                NSRange range = length <= 0 ? NSMakeRange(location-1, 1) : NSMakeRange(location, length);
                
                UITextPosition* startPosition = [tf positionFromPosition:beginning offset:range.location];
                UITextPosition* endPosition = [tf positionFromPosition:beginning offset:range.location + range.length];
                UITextRange* selectionRange = [tf textRangeFromPosition:startPosition toPosition:endPosition];
                [tf setSelectedTextRange:selectionRange];
            }
            [tf replaceRange:tf.selectedTextRange withText:@""];
        }
        else if ([_firstResponder isKindOfClass:[UITextView class]])
        {
            UITextView *tv = (UITextView *)_firstResponder;
            NSRange cursorPosition = [tv selectedRange];
            NSInteger index        = cursorPosition.location;
            if ([tv.text length] > 0)
            {
                if (index == 1)
                    tv.text = [tv.text substringFromIndex:index];
                else if (index > 1 && index < [tv.text length])
                    tv.text = [NSString stringWithFormat:@"%@%@", [tv.text substringToIndex:index-1], [tv.text substringFromIndex:index]];
                else if (index == [tv.text length])
                    tv.text = [tv.text substringToIndex:index-1];
                index = index > 1 ? index-1 : 0;
                [tv setSelectedRange:NSMakeRange(index, 0)];
            }
        }
    }
}

-(void)confirmOrWrap:(UIButton *)btn  //确认
{
    if (_firstResponder) {
        NSString *text = @"";
        if ([_firstResponder isKindOfClass:[UITextField class]])
        {
            UITextField *tf = (UITextField *)_firstResponder;
            [tf replaceRange:tf.selectedTextRange withText:@""];
            text = tf.text;
        }
        else if ([_firstResponder isKindOfClass:[UITextView class]])
        {
            UITextView *tf = (UITextView *)_firstResponder;
            text = tf.text;
        }
        if (self.confirmAction) {
            self.confirmAction(text);
        }
    }
}

@end
