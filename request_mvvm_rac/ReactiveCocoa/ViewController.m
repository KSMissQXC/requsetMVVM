//
//  ViewController.m
//  ReactiveCocoa
//
//  Created by xiaomage on 15/10/25.
//  Copyright © 2015年 xiaomage. All rights reserved.
//

#import "ViewController.h"

#import "GlobeHeader.h"
#import "RequestViewModel.h"
#import "Book.h"


@interface ViewController ()


@property (strong, nonatomic)RequestViewModel *requestModel;





@end

@implementation ViewController
#pragma mark - 懒加载
-(RequestViewModel *)requestModel{
    if (_requestModel == nil) {
        _requestModel = [[RequestViewModel alloc]init];
    }
    return _requestModel;
}


#pragma mark - 初始化

- (void)viewDidLoad {
    [super viewDidLoad];
 
    //发送请求
    RACSignal *requestSignal = [self.requestModel.requestCom execute:nil];
    
    //订阅请求信号
    [requestSignal subscribeNext:^(id x) {
        NSLog(@"%@",[x class]);
        
        NSLog(@"%zd",[x count]);
        Book *b = x[0];
        NSLog(@"%@",b.title);
        NSLog(@"%@",b);

    }];
    

}



@end
