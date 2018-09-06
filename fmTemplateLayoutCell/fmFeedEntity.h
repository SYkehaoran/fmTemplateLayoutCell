//
//  FDFeedEntity.h
//  Demo
//
//  Created by sunnyxx on 15/4/16.
//  Copyright (c) 2015年 forkingdog. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface fmFeedEntity : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *content;
@property (nonatomic, copy, readonly) NSString *time;
@property (nonatomic, copy, readonly) NSArray *imageArray;

@end
