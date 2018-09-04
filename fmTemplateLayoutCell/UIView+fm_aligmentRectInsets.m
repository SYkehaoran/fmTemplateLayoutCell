//
//  UIView+fm_aligmentRectInsets.m
//  fmTemplateLayoutCell
//
//  Created by 柯浩然 on 9/4/18.
//  Copyright © 2018 柯浩然. All rights reserved.
//

#import "UIView+fm_aligmentRectInsets.h"
#import <objc/runtime.h>

static NSString * const kAligmentRectInsetsKey = @"kAligmentRectInsetsKey";

@implementation UIView (fm_aligmentRectInsets)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(alignmentRectInsets);
        SEL swizzledSelector = @selector(_fm_alignmentRectInsets);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL didAddMethod =
        class_addMethod(class,
                        originalSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (UIEdgeInsets (^)(UIEdgeInsets))fm_aligmentRectInsets {
   return objc_getAssociatedObject(self, (__bridge const void * _Nonnull)(kAligmentRectInsetsKey));
}
- (void)setFm_aligmentRectInsets:(UIEdgeInsets (^)(UIEdgeInsets))fm_aligmentRectInsets {
    objc_setAssociatedObject(self, CFBridgingRetain(kAligmentRectInsetsKey), fm_aligmentRectInsets, OBJC_ASSOCIATION_COPY);
}

- (UIEdgeInsets)_fm_alignmentRectInsets {
    
    if (self.fm_aligmentRectInsets) {
        
        return self.fm_aligmentRectInsets(UIEdgeInsetsZero);
    }else {
        return [self _fm_alignmentRectInsets];
    }
}
@end
