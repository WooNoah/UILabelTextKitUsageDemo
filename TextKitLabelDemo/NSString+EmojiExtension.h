//
//  NSString+EmojiExtension.h
//  DianPing
//
//  Created by 吴迪 on 2019/12/14.
//  Copyright © 2019 yd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (EmojiExtension)

- (BOOL)isEmoji;

- (BOOL)isIncludingEmoji;

- (instancetype)removedEmojiString;

- (NSArray *)stringRanges;

- (instancetype)appendSubfixWithString:(NSString *)subfix label:(UILabel *)label labelRect:(CGRect)labelRect;

@end

NS_ASSUME_NONNULL_END
