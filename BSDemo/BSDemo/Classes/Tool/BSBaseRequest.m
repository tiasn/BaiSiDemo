//
//  BSBaseRequest.m
//  BaiSiDemo
//
//  Created by LTX on 2017/7/13.
//  Copyright © 2017年 LTX. All rights reserved.
//

#import "BSBaseRequest.h"
#import "AFNetworking.h"

@interface BSBaseRequest ()

@property (nonatomic, copy) NSString *urlString;

@property (nonatomic , copy) BSHTTPRequestCompletion completionBlock;

@property (nonatomic , strong) AFHTTPSessionManager *sessionManager;


@end

@implementation BSBaseRequest

/**
 *  配置请求地址
 */
+ (instancetype)requestWithURL:(NSString *)url {
    
    BSBaseRequest *request = [[BSBaseRequest alloc] init];
    request.urlString = url;
    
    return request;
    
}


/**
 *  发送网络请求
 *  @param methodType 请求方式 GET POST
 *  @param params 传入参数
 *  @param completion 请求完成回调
 */
- (NSURLSessionDataTask *)startWithMethod:(BSHTTPType)methodType params:(id)params completion:(BSHTTPRequestCompletion)completion {
    
    
    
    NSURLSessionDataTask *task = nil;
    self.completionBlock = completion;
    self.sessionManager = [self sessionManagerWithParams:params];
    
    if (methodType == BSHTTPTypeGET) {
        
        task = [self.sessionManager GET:[self.urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if (self.completionBlock) {
                self.completionBlock(responseObject, nil, YES);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            if (self.completionBlock) {
                self.completionBlock(nil, error.description, NO);
            }
            
        }];
        
        
    }else if (methodType == BSHTTPTypePOST) {
        
        task = [self.sessionManager POST:[self.urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (self.completionBlock) {
                self.completionBlock(responseObject, nil, YES);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (self.completionBlock) {
                self.completionBlock(nil, error.description, NO);
                
            }
        }];
        
    }
    
    
    return nil;
    
}

/**
 *  初始化AFHTTPSessionManager
 */
- (AFHTTPSessionManager *)sessionManagerWithParams:(NSDictionary *)params {
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    config.timeoutIntervalForRequest = 30.0f;
    
    AFHTTPSessionManager *sessionManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:config];
    
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain", @"text/json", @"text/javascript", @"text/html", nil];
    
    return sessionManager;
    
}



@end
