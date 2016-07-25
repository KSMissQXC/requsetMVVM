//
//  Book.m
//  ReactiveCocoa
//
//  Created by apple on 16/7/25.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import "Book.h"

@implementation Book

+ (instancetype)bookWithDict:(NSDictionary *)dict
{
    Book *book = [[Book alloc] init];
    
    book.title = dict[@"title"];
    book.subtitle = dict[@"subtitle"];
    return book;
}

@end
