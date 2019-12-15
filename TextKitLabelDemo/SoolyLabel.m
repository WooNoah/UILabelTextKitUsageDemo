//
//  SoolyLabel.m
//  TextKitLabelDemo
//
//  Created by 吴迪 on 2019/12/15.
//  Copyright © 2019 No. All rights reserved.
//

#import "SoolyLabel.h"

@interface SoolyLabel()

@property (nonatomic, strong) NSTextStorage *textStorage;

@property (nonatomic, strong) NSLayoutManager *layoutManager;

@property (nonatomic, strong) NSTextContainer *textContainer;

@property (nonatomic, copy) NSArray *urlRanges;
@property (nonatomic, copy) NSArray *topicRanges;
@property (nonatomic, copy) NSArray *atRanges;

@end

@implementation SoolyLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareTextSystem];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self prepareTextSystem];
    }
    return self;
}


- (void)setText:(NSString *)text {
    [super setText:text];
    
    [self prepareText];
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    [self prepareText];
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    
    [self prepareText];
}

- (void)setTextColor:(UIColor *)textColor {
    [super setTextColor:textColor];
    
    [self prepareText];
}


- (void)setMatchRanges:(NSArray *)matchRanges {
    _matchRanges = matchRanges;
    
    for (NSString *regxString in matchRanges) {
        [self findRangeWithPattern:regxString];
    }
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSInteger glyphNumber = self.layoutManager.numberOfGlyphs;
    NSLog(@"%zd",glyphNumber);
    
    
}

#pragma mark -

- (void)prepareTextSystem {
    self.adjustsFontSizeToFitWidth = true;
    
    // 打开交互
    self.userInteractionEnabled = true;
    
    // 准备文本内容
    [self prepareText];
    
    // 设置对象的关系
    [self.textStorage addLayoutManager:self.layoutManager];
    [self.layoutManager addTextContainer:self.textContainer];
    
}

/// 准备文本内容 - 使用TextStorage 接管 label内容
- (void)prepareText {
    
    if (self.attributedText) {
        [self.textStorage setAttributedString:self.attributedText];
    }else if (self.text) {
        NSAttributedString *str = [[NSAttributedString alloc]initWithString:self.text];
        [self.textStorage setAttributedString:str];
    }else {
        NSAttributedString *str = [[NSAttributedString alloc]initWithString:@""];
        [self.textStorage setAttributedString:str];
        return;
    }
    
    // 设置Text属性
    [self setupTextAttributes];
    
}

- (void)setupTextAttributes {
    
    [self.textStorage addAttributes:@{NSFontAttributeName: self.font, NSForegroundColorAttributeName: self.textColor} range:NSMakeRange(0, self.textStorage.length)];
    

    for (NSString *rangeString in self.urlRanges) {
        [self.textStorage addAttributes:@{NSForegroundColorAttributeName: [UIColor blueColor]} range:NSRangeFromString(rangeString)];
    }
    
    for (NSString *rangeString in self.topicRanges) {
        [self.textStorage addAttributes:@{NSForegroundColorAttributeName: [UIColor blueColor]} range:NSRangeFromString(rangeString)];
    }
    
    for (NSString *rangeString in self.atRanges) {
        [self.textStorage addAttributes:@{NSForegroundColorAttributeName: [UIColor blueColor]} range:NSRangeFromString(rangeString)];
    }
}

#pragma mark - 正则

- (NSArray *)findRangeWithPattern:(NSString *)pattern {
    
    NSRegularExpression *regx = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    if (!regx) {
        return nil;
    }
    
    NSArray *matches = [regx matchesInString:self.textStorage.string options:NSMatchingReportCompletion range:NSMakeRange(0, self.textStorage.length)];
    
    NSMutableArray *ranges = @[].mutableCopy;
    for (NSTextCheckingResult *result in matches) {
        [ranges addObject:NSStringFromRange(result.range)];
    }
    
    return ranges;
}


#pragma mark -
- (CGRect)boundingRectForCharacterRange:(NSRange)range
{
    NSRange glyphRange;

    // Convert the range for glyphs.
    [self.layoutManager characterRangeForGlyphRange:range actualGlyphRange:&glyphRange];

    return [self.layoutManager boundingRectForGlyphRange:glyphRange inTextContainer:self.textContainer];
}

#pragma mark -
- (NSTextStorage *)textStorage {
    if (!_textStorage) {
        _textStorage = [[NSTextStorage alloc]init];
    }
    return _textStorage;
}

- (NSLayoutManager *)layoutManager {
    if (!_layoutManager) {
        _layoutManager = [[NSLayoutManager alloc]init];
        _layoutManager.showsInvisibleCharacters = YES;
//        _layoutManager.delegate = self;
    }
    return _layoutManager;
}

- (NSTextContainer *)textContainer {
    if (!_textContainer) {
        _textContainer = [[NSTextContainer alloc]init];
    }
    return _textContainer;
}

- (NSArray *)urlRanges {
    if (!_urlRanges) {
        NSString *pattern = @"\\b(([\\w-]+://?|www[.])[^\\s()<>]+(?:\\([\\w\\d]+\\)|([^[:punct:]\\s]|/)))";
        _urlRanges = [self findRangeWithPattern:pattern];
    }
    return _urlRanges;
}

- (NSArray *)topicRanges {
    if (!_topicRanges) {
        NSString *pattern = @"#[^#]+#";
        _topicRanges = [self findRangeWithPattern:pattern];
    }
    return _topicRanges;
}

- (NSArray *)atRanges {
    if (!_atRanges) {
        NSString *pattern = @"@[\\u4e00-\\u9fa5a-zA-Z0-9_-]{2,30}";
        _atRanges = [self findRangeWithPattern:pattern];
    }
    return _atRanges;
}

@end
