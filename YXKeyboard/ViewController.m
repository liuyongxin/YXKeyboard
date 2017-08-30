//
//  ViewController.m
//  YXKeyboard
//
//  Created by DZH_Louis on 2017/8/25.
//  Copyright © 2017年 Louis. All rights reserved.
//

#import "ViewController.h"
#import "YXKeyboardView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UITextView *textV = [[UITextView alloc]initWithFrame:CGRectMake(100, 100, 100, 40)];
    textV.backgroundColor = [UIColor redColor];
    [self.view addSubview:textV];
    YXKeyboardView *keyboardV = [[YXKeyboardView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 216)];
    [keyboardV bindFirstResponder:textV];
    
    UITextField *textF = [[UITextField alloc]initWithFrame:CGRectMake(100, 200, 100, 40)];
    textF.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:textF];
    YXKeyboardView *keyboard2 = [[YXKeyboardView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 216)];
    [keyboard2 bindFirstResponder:textF];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
