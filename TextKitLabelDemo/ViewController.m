//
//  ViewController.m
//  TextKitLabelDemo
//
//  Created by 吴迪 on 2019/12/15.
//  Copyright © 2019 No. All rights reserved.
//

#import "ViewController.h"
#import "SoolyLabel.h"
#import <Masonry/Masonry.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *string = @"This is a long titlessss Withssssssss,This is a long titlessss Withssssssss";
    
    SoolyLabel *testLabel = [[SoolyLabel alloc]initWithFrame:CGRectMake(100, 200, 100, 100)];
    testLabel.numberOfLines = 2;
    testLabel.backgroundColor = [UIColor grayColor];
    testLabel.textColor = [UIColor cyanColor];
    testLabel.font = [UIFont systemFontOfSize:15];
    testLabel.lineBreakMode = NSLineBreakByCharWrapping;
    testLabel.text = string;
    [self.view addSubview:testLabel];
    
    [testLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view);
        make.left.equalTo(@100);
    }];
    
    
//    SoolyLabel *testLabel1 = [[SoolyLabel alloc]initWithFrame:CGRectMake(100, 400, 200, 88)];
//    testLabel1.numberOfLines = 2;
//    testLabel1.backgroundColor = [UIColor grayColor];
////    testLabel1.textColor = [UIColor whiteColor];
//    testLabel1.font = [UIFont systemFontOfSize:15];
//    testLabel1.text = @"url: https://www.baidu.com";
//    [self.view addSubview:testLabel1];
//
//    [testLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(testLabel.mas_bottom).offset(50);
//        make.centerX.equalTo(testLabel);
//    }];
}


@end
