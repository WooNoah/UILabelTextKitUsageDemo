//
//  SoolyLabel.h
//  TextKitLabelDemo
//
//  Created by 吴迪 on 2019/12/15.
//  Copyright © 2019 No. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SoolyLabelDelegate <NSObject>

- (void)labelDidSelectedLink:(NSString *)text;

- (void)labelDidSelectedTopic:(NSString *)text;

- (void)labelDidSelectedAt:(NSString *)text;

@end


@interface SoolyLabel : UILabel

@property (nonatomic, weak) id<SoolyLabelDelegate> delegate;


@property (nonatomic,copy) NSArray *matchRanges;


@end

NS_ASSUME_NONNULL_END
