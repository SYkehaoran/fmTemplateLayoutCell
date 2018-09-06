//
//  FDFeedEntity.m
//  Demo
//
//  Created by sunnyxx on 15/4/16.
//  Copyright (c) 2015年 forkingdog. All rights reserved.
//

#import "fmFeedEntity.h"

@implementation fmFeedEntity

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = super.init;
    if (self) {
        _title = dictionary[@"title"];
        _content = dictionary[@"content"];
        _time = dictionary[@"time"];
        _imageArray = dictionary[@"imageArray"];
    }
    return self;
}


@end
