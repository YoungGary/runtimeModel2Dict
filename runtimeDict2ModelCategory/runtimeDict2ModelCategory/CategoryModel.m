//
//  CategoryModel.m
//  runtimeDict2ModelCategory
//
//  Created by YOUNG on 2017/3/21.
//  Copyright © 2017年 Young. All rights reserved.
//


#import "CategoryModel.h"

@implementation CategoryModel

+ (NSDictionary *)arrayContainModelClass
{
    return @{ @"spus": @"FoodModel" };
}

@end

@implementation FoodModel

+ (NSDictionary *)arrayContainModelClass
{
    return @{ @"foodId": @"id" };
}

@end
