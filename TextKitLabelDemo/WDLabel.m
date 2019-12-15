//
//  WDLabel.m
//  TextKitLabelDemo
//
//  Created by 吴迪 on 2019/12/15.
//  Copyright © 2019 No. All rights reserved.
//

#import "WDLabel.h"
#import "NSString+EmojiExtension.h"

@interface WDLabel()

@property (strong, nonatomic) NSTextStorage *textStorage;
@property (strong, nonatomic) NSLayoutManager *layoutManager;

@end

@implementation WDLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
//        NSTextContainer *textContainer = [[NSTextContainer alloc]init];
//        textContainer.heightTracksTextView = YES;
//        textContainer.lineFragmentPadding = 0;
//
//
//
//
//        self.translatesAutoresizingMaskIntoConstraints = false;
//        self.backgroundColor = [UIColor lightGrayColor];
//        self.lineBreakMode = NSLineBreakByCharWrapping;
//        self.userInteractionEnabled = true;
//
//        textContainer.lineBreakMode = self.lineBreakMode;
//        [self.layoutManager addTextContainer:textContainer];
//        [self.textStorage addLayoutManager: self.layoutManager];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    NSUInteger length = self.attributedText.length;
    
    NSLog(@"%zd",length);
    NSMutableString *originStr = self.attributedText.string.mutableCopy;
    NSMutableString *resultString = originStr.mutableCopy;
    if (originStr.length > 3) {
//        NSLog(@"substringRange: %@ \n",NSStringFromRange(substringRange));
//        if ([substring isEmoji] ? substringRange.location == originStr.length - 2 : substringRange.location == originStr.length - 1) {
//            [resultString appendString:@"..."];
//            *stop = YES;
//        }else {
//            [resultString appendString:substring];
//        }
        
                
        [originStr deleteCharactersInRange:NSMakeRange(originStr.length - 1 - 3, 3)];
        [originStr appendString:@"..."];
//        originStr = [originStr stringByReplacingCharactersInRange:NSMakeRange(originStr.length - 1 - 3, 3) withString:@"..."];
    }
    NSMutableAttributedString *attrM = [[NSMutableAttributedString alloc]initWithString:originStr];
    self.attributedText = attrM;
}

//
//- (void)setAttributedText:(NSAttributedString *)attributedText {
//    [super setAttributedText:attributedText];
//
//    [self.textStorage setAttributedString:attributedText];
//}
//
//- (NSTextStorage *)textStorage {
//    if (!_textStorage) {
//        _textStorage = [[NSTextStorage alloc]init];
//    }
//    return _textStorage;
//}
//
//- (NSLayoutManager *)layoutManager {
//    if (!_layoutManager) {
//        _layoutManager = [[NSLayoutManager alloc]init];
//        _layoutManager.usesFontLeading = false;
//        _layoutManager.allowsNonContiguousLayout = true;
//    }
//    return _layoutManager;
//}
//
//
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code

//    [self.layoutManager enumerateLineFragmentsForGlyphRange:<#(NSRange)#> usingBlock:^(CGRect rect, CGRect usedRect, NSTextContainer * _Nonnull textContainer, NSRange glyphRange, BOOL * _Nonnull stop) {
//        <#code#>
//    }]
    
    for (NSUInteger i = 0; i < [self.layoutManager.textContainers count]; i++) {
        NSTextContainer *container = self.layoutManager.textContainers[i];
//        CGPoint origin = [self.textOrigins[i] CGPointValue];

        NSRange glyphRange = [self.layoutManager glyphRangeForTextContainer:container];

        [self.layoutManager drawGlyphsForGlyphRange:glyphRange atPoint:CGPointMake(0, 0)];
    }

}

@end
