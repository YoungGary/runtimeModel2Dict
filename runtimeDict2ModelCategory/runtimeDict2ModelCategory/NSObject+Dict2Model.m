//
//  NSObject+Dict2Model.m
//  runtimeDict2ModelCategory
//
//  Created by YOUNG on 2017/3/21.
//  Copyright © 2017年 Young. All rights reserved.
//

#import "NSObject+Dict2Model.h"

@implementation NSObject (Dict2Model)

+ (instancetype)objectWithDictionary:(NSDictionary *)dict{
    id obj = [[self alloc] init];
    
    // 获取所有的成员变量
    unsigned int count;
    
    Ivar *ivars = class_copyIvarList(self, &count);
    
    for (unsigned int i = 0; i < count; i++)
    {
        Ivar ivar = ivars[i];
        
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        
        NSString *key = [ivarName substringFromIndex:1];
        
        id value = dict[key];
        
        
        //如果value 中还有字典  要进行二级转换
        if ([value isKindOfClass:[NSDictionary class]])
        {
            NSString *type = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
            
            NSRange range = [type rangeOfString:@"\""];
            
            type = [type substringFromIndex:range.location + range.length];
            
            range = [type rangeOfString:@"\""];
            
            type = [type substringToIndex:range.location];
            
            Class modelClass = NSClassFromString(type);
            
            if (modelClass)
            {
                value = [modelClass objectWithDictionary:value];
            }
        }
        
        // 如果value是数组类型
        if ([value isKindOfClass:[NSArray class]])
        {
            if ([self respondsToSelector:@selector(arrayContainModelClass)])
            {
                NSMutableArray *models = [NSMutableArray array];
                
                NSString *type = [self arrayContainModelClass][key];
                Class classModel = NSClassFromString(type);
                for (NSDictionary *dict in value)
                {
                    id model = [classModel objectWithDictionary:dict];
                    [models addObject:model];
                }
                value = models;
            }
        }
        
        if (value)
        {
            [obj setValue:value forKey:key];
        }
    }
    
    // 释放ivars
    free(ivars);
    
    return obj;
}
@end
