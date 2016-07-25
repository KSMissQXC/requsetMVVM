//
//  RequestViewModel.m
//  ReactiveCocoa
//
//  Created by apple on 16/7/25.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import "RequestViewModel.h"
#import "AFNetworking.h"
#import "Book.h"
#import "MBProgressHUD+XMG.h"


@implementation RequestViewModel

-(instancetype)init{
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

-(void)setup{
    _requestCom = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        NSLog(@"---%@",input);
        //创建信号,并发送网络请求数据
        RACSignal *requestSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            //发送网络请求
            // 创建请求管理者
            AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
            [mgr GET:@"https://api.douban.com/v2/book/search" parameters:@{@"q":@"美女"} progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                //获取返回来的字典数组
                NSArray *dictArray = responseObject[@"books"];
                
                NSArray *modelArray = [[dictArray.rac_sequence map:^id(id value) {
                    return [Book bookWithDict:value];
                }] array];
                
                //发送数据
                [subscriber sendNext:modelArray];
                [subscriber sendCompleted];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
            }];
            
            return nil;
            
        }];
        return requestSignal;

    }];
    
    //监听命令执行是否完成
    [[_requestCom.executing skip:1] subscribeNext:^(id x) {
        if ([x boolValue] == YES) {
            // 正在执行
            NSLog(@"正在执行");
            // 显示蒙版
            [MBProgressHUD showMessage:@"正在请求数据.."];
            
        }else{
            // 执行完成
            // 隐藏蒙版
            [MBProgressHUD hideHUD];
            
            NSLog(@"执行完成");
        }

        
        
        
    }];
    
    
    
    
    
}

@end
