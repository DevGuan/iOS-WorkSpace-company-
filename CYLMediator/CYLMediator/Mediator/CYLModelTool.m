//
//  CYLModelTool.m
//  CYLMediator
//
//  Created by 迟钰林 on 2017/6/28.
//  Copyright © 2017年 GARY. All rights reserved.
//

#import "CYLModelTool.h"
#import <objc/runtime.h>

@implementation CYLModelTool
+ (NSDictionary*)modelToDict:(id)model
{
    //模型转字典
    NSMutableDictionary *ModelDic = [NSMutableDictionary dictionary];
    Class modelClass = [model class];
    unsigned int outCount = 0;
    objc_property_t *properties = class_copyPropertyList(modelClass, &outCount);
    for (int i = 0; i < outCount; i ++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
        id propertyValue = [model valueForKey:propertyName];
        if (propertyValue) [ModelDic setValue:propertyValue forKey:propertyName];
    }
    
    return ModelDic;
}

+ (id)dictToSimpleModel:(NSDictionary*)dict modeClass:(Class)modelClass
{
    //字典转模型
    unsigned int outCount = 0;
    id model = [modelClass new];
    objc_property_t *propertys = class_copyPropertyList(modelClass, &outCount);
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = propertys[i];
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
        [model setValue:dict[propertyName] forKey:propertyName];
    }
    
    return model;
}
@end
