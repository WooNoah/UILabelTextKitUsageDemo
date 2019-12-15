//
//  NSString+EmojiExtension.m
//  DianPing
//
//  Created by 吴迪 on 2019/12/14.
//  Copyright © 2019 yd. All rights reserved.
//

#import "NSString+EmojiExtension.h"


@implementation NSString (EmojiExtension)

- (BOOL)isEmoji {
    const unichar high = [self characterAtIndex: 0];
    
    // Surrogate pair (U+1D000-1F77F)
    if (0xd800 <= high && high <= 0xdbff) {
        const unichar low = [self characterAtIndex: 1];
        const int codepoint = ((high - 0xd800) * 0x400) + (low - 0xdc00) + 0x10000;
        
        return (0x1d000 <= codepoint && codepoint <= 0x1f77f);
        
    // Not surrogate pair (U+2100-27BF)
    } else {
        return (0x2100 <= high && high <= 0x27bf);
    }
}

- (BOOL)isIncludingEmoji {
    BOOL __block result = NO;
    
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock: ^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop) {
        if ([substring isEmoji]) {
            *stop = YES;
            result = YES;
        }
    }];
    
    return result;
}

- (instancetype)removedEmojiString {
    NSMutableString* __block buffer = [NSMutableString stringWithCapacity:[self length]];
    
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock: ^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop) {
        [buffer appendString:([substring isEmoji])? @"": substring];
    }];
    
    return buffer;
}

- (NSArray *)stringRanges {
    NSMutableArray *tempArrM = @[].mutableCopy;
    __block NSInteger startIdx = -1;
    __block NSInteger length = 0;
    
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock: ^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop) {
        
        BOOL isEmoji = [substring isEmoji];
        if (!isEmoji) {
            if (startIdx == -1) {
                startIdx = substringRange.location;
            }
            length++;
        }else {
            if (startIdx != -1) {
                NSRange range = NSMakeRange(startIdx, length);
                [tempArrM addObject:NSStringFromRange(range)];
            }
            
            startIdx = -1;
            length = 0;
        }
        
    }];
    return tempArrM;
}

//- (instancetype)appendSubfixWithString:(NSString *)subfix label:(UILabel *)label labelRect:(CGRect)labelRect {
//    
//    if ([subfix length] <= 0) {
//        subfix = @"...";
//    }
//    
//    CGRect lRect;
//    if (!CGRectEqualToRect(labelRect, CGRectZero)) {
//        lRect = labelRect;
//    }else {
//        lRect = label.frame;
//    }
//    
//    UILabel *fakeLabel = [[UILabel alloc]init];
//    fakeLabel.frame = lRect;
//    fakeLabel.numberOfLines = label.numberOfLines;
//    fakeLabel.font = label.font;
//    fakeLabel.text = label.text;
//    
//    [fakeLabel sizeToFit];
//    CGFloat labelHeight = fakeLabel.bounds.size.height;
//    
//    NSString *text = label.text;
////    [text boundingRectWithSize:<#(CGSize)#> options:<#(NSStringDrawingOptions)#> attributes:<#(nullable NSDictionary<NSAttributedStringKey,id> *)#> context:<#(nullable NSStringDrawingContext *)#>]
//}

//- (NSArray *)stringRanges {
//    NSMutableArray *tempArrM = @[].mutableCopy;
//    NSInteger startIdx = -1;
//    NSInteger length = 0;
//    for (int i = 0; i < self.length; i++) {
//        unichar c = [self characterAtIndex:i];
//        if (i < self.length - 1) {
//            NSString *currentCharacter = [NSString stringWithFormat:@"%c",c];
//            unichar nextc = [self characterAtIndex:i + 1];
//            NSString *nextCharacter = [NSString stringWithFormat:@"%c",nextc];
//            if (![currentCharacter isEmoji]) {
//                if (startIdx == -1) startIdx = i;
//                length++;
//                if ([nextCharacter isEmoji]) {
//                    NSRange range = NSMakeRange(startIdx, length);
//                    [tempArrM addObject:NSStringFromRange(range)];
//                }
//            }else {
//                startIdx = -1;
//                length = 0;
//            }
//        }
//    }
//    return tempArrM;
//}

@end
