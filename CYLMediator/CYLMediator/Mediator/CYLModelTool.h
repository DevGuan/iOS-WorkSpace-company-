//
//  CYLModelTool.h
//  CYLMediator
//
//  Created by 迟钰林 on 2017/6/28.
//  Copyright © 2017年 GARY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYLModelTool : NSObject
+ (NSDictionary*)modelToDict:(id)model;
+ (id)dictToSimpleModel:(NSDictionary*)dict modeClass:(Class)modelClass;
@end
