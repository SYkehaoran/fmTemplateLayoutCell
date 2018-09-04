//
//  UIView+fm_aligmentRectInsets.h
//  fmTemplateLayoutCell
//
//  Created by 柯浩然 on 9/4/18.
//  Copyright © 2018 柯浩然. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (fm_aligmentRectInsets)
/// 主动设置View aligmentRectInsets，为了当View不存在之后他身上的间距也一起不存在
@property(nonatomic, copy) UIEdgeInsets (^fm_aligmentRectInsets)(UIEdgeInsets originInsets);
@end
