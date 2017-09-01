//
//  UILabel+extension.m
//  Label
//
//  Created by 绝影 on 16/1/30.
//  Copyright © 2016年 juangua. All rights reserved.
//

#import "UILabel+SNExtension.h"
#import <objc/runtime.h>
#import <CoreText/CoreText.h>

@implementation UILabel (SNExtension)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
   
        SEL selectors[] = {
            @selector(setText:),
        };
        
        for (NSUInteger index = 0; index < sizeof(selectors) / sizeof(SEL); ++index) {
            SEL originalSelector = selectors[index];
            SEL swizzledSelector = NSSelectorFromString([@"sn_" stringByAppendingString:NSStringFromSelector(originalSelector)]);
            
            Method originalMethod = class_getInstanceMethod(self, originalSelector);
            Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);
            
            BOOL addedSuccess = class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
            if (addedSuccess)
            {
                class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
            }
            else
            {
                method_exchangeImplementations(originalMethod, swizzledMethod);
            }
        }
    });
}

- (void)sn_setText:(NSString *)text
{
    [self sn_setText:text];
    if (self.sn_lineSpace > 0)
    {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = self.sn_lineSpace;
        paragraphStyle.baseWritingDirection = NSWritingDirectionLeftToRight;
        paragraphStyle.lineBreakMode = self.lineBreakMode;
        paragraphStyle.alignment = self.textAlignment;
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.text length])];
        [attributedString addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, [self.text length])];

        self.attributedText = attributedString;
    }
    
    if (self.sn_wordSpace > 0 )
    {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
        [attributedString addAttribute:(__bridge NSString *)kCTKernAttributeName value:@(self.sn_wordSpace) range:NSMakeRange(0, [attributedString length])];
        self.attributedText = attributedString;
    }
}

#pragma mark - 添加属性

- (CGFloat)sn_lineSpace
{
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

- (void)setSn_lineSpace:(CGFloat)sn_lineSpace
{
    objc_setAssociatedObject(self, @selector(sn_lineSpace), @(sn_lineSpace), OBJC_ASSOCIATION_RETAIN);
}

- (CGFloat)sn_wordSpace
{
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

- (void)setSn_wordSpace:(CGFloat)sn_wordSpace
{
    objc_setAssociatedObject(self, @selector(sn_wordSpace), @(sn_wordSpace), OBJC_ASSOCIATION_RETAIN);
}

@end
