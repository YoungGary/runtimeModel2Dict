//
//  NSObject+Dict2Model.h
//  runtimeDict2ModelCategory
//
//  Created by YOUNG on 2017/3/21.
//  Copyright © 2017年 Young. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>


@protocol KeyValue <NSObject>

@optional
/**
 *  数组中需要转换的模型类
 *
 *  @return 字典中的key是数组属性名，value是数组中存放模型的Class（Class类型或者NSString类型） 
 
    e.g. Person类中有books属性 @property (nonatomic, strong) NSArray *books;   book 是属于Book类的
    那么该方法返回   return @{ @"books" : @"Book" };
 
 */
+ (NSDictionary *)arrayContainModelClass;



@end

@interface NSObject (Dict2Model)<KeyValue>

+ (instancetype)objectWithDictionary:(NSDictionary *)dict;



@end
