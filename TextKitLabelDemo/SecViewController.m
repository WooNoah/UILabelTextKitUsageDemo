//
//  SecViewController.m
//  TextKitLabelDemo
//
//  Created by 吴迪 on 2019/12/15.
//  Copyright © 2019 No. All rights reserved.
//

#import "SecViewController.h"
#import "SoolyLabel.h"
#import <Masonry/Masonry.h>
#import "WDLabel.h"

@interface SecViewController ()

@end

@implementation SecViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *string = @"This is a long titlessss Withssssssss,This is a long titlessss Withssssssss";
    
    SoolyLabel *testLabel = [[SoolyLabel alloc]initWithFrame:CGRectMake(100, 200, 100, 100)];
    testLabel.numberOfLines = 3;
    testLabel.backgroundColor = [UIColor grayColor];
    testLabel.textColor = [UIColor cyanColor];
    testLabel.font = [UIFont systemFontOfSize:15];
    testLabel.lineBreakMode = NSLineBreakByCharWrapping;
    testLabel.text = string;
    [self.view addSubview:testLabel];
    
    [testLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view);
        make.left.equalTo(@10);
    }];
    
    
    WDLabel *label = [[WDLabel alloc]init];
    label.frame = CGRectMake(100, 100, 100, 44);
    label.numberOfLines = 3;
    label.font = [UIFont systemFontOfSize:15];
    label.backgroundColor = [UIColor blackColor];
    label.textColor = [UIColor redColor];
    
    NSString *word = @"ienixenixeinxeinxenixenixnoexenoononxenoxenoxenoxenoxenoxenoxenoxenoxeoneonnoenoxeonxebudibxeibxebi";
    NSString *emoji = @"😀🤣🙃😊🥰😚😋😛🤨😜🤪😛😙🥰😇😇😆";
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:word];
    NSMutableAttributedString *emojiAttr = [[NSMutableAttributedString alloc]initWithString:emoji];
    [attr appendAttributedString:emojiAttr];
    
    label.attributedText = attr;
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20 + 84);
        make.centerX.equalTo(self.view);
        make.left.equalTo(self.view).offset(10);
    }];
    
    
    testLabel.attributedText = attr;
}

@end
