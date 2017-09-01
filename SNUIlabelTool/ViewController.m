//
//  ViewController.m
//  SNUIlabelTool
//
//  Created by 周文超 on 2017/9/1.
//  Copyright © 2017年 超超. All rights reserved.
//

#import "ViewController.h"
#import "UILabel+SNExtension.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *label = [[UILabel alloc] init];
    [self.view addSubview:label];
    label.frame = CGRectMake(50.f, 200.f, 300.f, 100.f);
    label.numberOfLines = 0;
    label.sn_lineSpace = 10.f;
    label.sn_wordSpace = 5.f;
    label.text = @"灵魂歌手开唱瞬间能击碎万颗心他不属于瞬间他属于永恒那些感动了自己的歌是最好的证明如今不知多少人听";
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
