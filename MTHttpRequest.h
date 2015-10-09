//
//  MTHttpRequest.h
//  yimouleng
//
//  Created by Ely on 15/6/12.
//  Copyright (c) 2015年 yimouleng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@interface MTHttpRequest : NSObject

/**
 *  一般的get请求
 *
 *  @param url     传入的地址Url
 *  @param param   参数(可有可无)
 *  @param success 成功回调函数
 *  @param failure 失败回调函数
 */
+ (void)get:(NSString *)url
                 parameters:(id)param
                    success:(void (^)(id result))success
                    failure:(void (^)(NSError *error))failure;
/**
 *  基本用来上传参数的post请求
 *
 *  @param url     传入的地址Url
 *  @param param   参数（required）
 *  @param success 成功回调函数
 *  @param failure 失败回调函数
 */
+ (void)post:(NSString *)url
                  parameters:(id)param
                     success:(void (^)(id result))success
                     failure:(void (^)(NSError *error))failure;
/**
 *  上传图片（支持多张上传和单张上传）
 *
 *  @param url     上传地址
 *  @param param   除文件外的后台要求参数
 *  @param file    文件数组（文件流or数据流）
 *  @param fileKey 服务器用来解析的字段
 *  @param success 成功回调函数
 *  @param failure 失败回调函数
 */

+ (void)post:(NSString *)url
                  parameters:(id)param
                   imageFile:(NSArray*)file
                     fileKey:(NSString*)fileKey
                     success:(void (^)(id result))success
                     failure:(void (^)(NSError *error))failure;


/**
 *  上传视频
 *
 *  @param url     上传地址
 *  @param param   除文件外的后台要求参数
 *  @param file    文件数组（文件流or数据流）
 *  @param fileKey 服务器用来解析的字段
 *  @param success 成功回调函数
 *  @param failure 失败回调函数
 */
+ (void)post:(NSString *)url
  parameters:(id)param
   videoFile:(NSArray*)file
     fileKey:(NSString*)fileKey
     success:(void (^)(id result))success
     failure:(void (^)(NSError *error))failure;

/**
 *  判断空数据  
 */

+ (BOOL) isBlankString:(id)obj;


@end
