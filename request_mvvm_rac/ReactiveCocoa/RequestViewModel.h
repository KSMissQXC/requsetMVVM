//
//  RequestViewModel.h
//  ReactiveCocoa
//
//  Created by apple on 16/7/25.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GlobeHeader.h"


@interface RequestViewModel : NSObject
//发送网络请求的命令
@property (strong, nonatomic)RACCommand *requestCom;




@end
