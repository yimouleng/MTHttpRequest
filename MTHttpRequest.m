//
//  MTHttpRequest.m
//  yimouleng
//
//  Created by Ely on 15/6/12.
//  Copyright (c) 2015年 yimouleng. All rights reserved.
//

#import "MTHttpRequest.h"

@implementation MTHttpRequest
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
    failure:(void (^)(NSError *error))failure
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //网络请求时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 10.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
     
     [manager GET:url parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //JSON解析
         
         //直接将JSON传出去
         success([NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil]);
         
        
    
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
       
        failure(error);
        
     
    }];
    
    
}
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
     failure:(void (^)(NSError *error))failure
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 10.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];

     [manager POST:url parameters: param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
         success([NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil]);
       
    
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        failure(error);
        
    }];
    
}
/**
 *  上传图片（支持多张上传和单张上传）
 *
 *  @param url     上传地址
 *  @param param   除文件外的后台要求参数
 *  @param file    文件数组（文件流or数据流）
 *  @param fileKey 后台要求的文件字段
 *  @param success 成功回调函数
 *  @param failure 失败回调函数
 */
+ (void)post:(NSString *)url
  parameters:(id)param
   imageFile:(NSArray*)file
     fileKey:(NSString*)fileKey
     success:(void (^)(id result))success
     failure:(void (^)(NSError *error))failure
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //超时时间设置
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 10.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
   
     manager.responseSerializer = [AFHTTPResponseSerializer serializer];
     [manager POST:url parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
         if([file[0] isEqual:[NSString class]]){
                //上传文件附加到 formData 中
                //添加文件数据(文件流)
                //参数1: 文件路径（FileURL）
                //参数2: 接口中数据的key值（name）
                //参数3: 上传后的文件名(不要重名)（fileName）
                //参数4: 文件类型（mimeType）
             
             for(int i=0;i<file.count;i++){
                
                 //加盖时间戳
                 NSDate *datenow = [NSDate date];
                 NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
                 
                 [formData appendPartWithFileURL:[NSURL fileURLWithPath:file[i]] name:fileKey fileName:[NSString stringWithFormat:@"%@.png",timeSp] mimeType:@"image/png" error:nil];
                
             }
  
             
         }else if ([file[0] isEqual:[NSData class]]){
             //添加文件数据(数据流)
             //参数1: 文件二进制数据（FileData）
             //参数2: 接口中数据的key值（name）
             //参数3: 上传后的文件名(不要重名)（fileName）
             //参数4: 文件类型（mimeType）
             
             for(int i=0;i<file.count;i++){
                 
                 //加盖时间戳
                 NSDate *datenow = [NSDate date];
                 NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
                 
                 [formData appendPartWithFileData:file[i] name:fileKey fileName:[NSString stringWithFormat:@"%@.png",timeSp] mimeType:@"image/png"];
                 
             }
                 
            
         }
             
       
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
            success([NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil]);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
            failure(error);
    }];
    
  
    
}
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
     failure:(void (^)(NSError *error))failure
{
}


/**
 *  判断空数据
 */

+ (BOOL) isBlankString:(id)obj {
    if (obj == nil || obj == NULL) {
        return YES;
    }
    if ([obj isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[obj stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}


@end
