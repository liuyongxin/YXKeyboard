//
//  YXKeyboardView.h
//  YXKeyboard
//
//  Created by DZH_Louis on 2017/8/25.
//  Copyright © 2017年 Louis. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,YXKeyboardType){
    YXKeyboardTypeOfNumber,     //数字
    YXKeyboardTypeOfLowercaseLetter,        //小写字母
    YXKeyboardTypeOfUppercaseLetter,        //大写字母
    YXKeyboardTypeOfSymbol,      //符号
};

@interface YXKeyboardView : UIView

@property (nonatomic,assign)YXKeyboardType type;
@property (nonatomic ,weak)UIResponder *firstResponder;
@property(nonatomic,copy)void(^confirmAction)(NSString *text);

/**
 * 绑定第一响应者
 * @param responder 第一响应者
 */
- (void)bindFirstResponder:(UIResponder *)responder;

@end
