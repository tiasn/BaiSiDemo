//
//  BSBaseRequest.h
//  BaiSiDemo
//
//  Created by LTX on 2017/7/13.
//  Copyright © 2017年 LTX. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, BSHTTPType){
    BSHTTPTypeGET,
    BSHTTPTypePOST,
};

typedef void(^BSHTTPRequestCompletion)(id responseObject, NSString *message, BOOL success);


@interface BSBaseRequest : NSObject

/**
 *  配置请求地址
 */
+ (instancetype)requestWithURL:(NSString *)url;


/**
 *  发送网络请求
 *  @param methodType 请求方式 GET POST
 *  @param params 传入参数
 *  @param completion 请求完成回调
 */
- (NSURLSessionDataTask *)startWithMethod:(BSHTTPType)methodType
                                   params:(id)params
                               completion:(BSHTTPRequestCompletion)completion;


@end
