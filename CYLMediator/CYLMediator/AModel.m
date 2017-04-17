//
//  AModel.m
//  CYLMediator
//
//  Created by GARY on 2017/4/13.
//  Copyright © 2017年 GARY. All rights reserved.
//

#import "AModel.h"

@interface AModel ()
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSDictionary *dict;
@end

@implementation AModel
- initWithName:(NSString*)name uid:(NSString*)uid password:(NSString*)passwoord
{
    if (self = [super init]) {
        self.name = name;
        self.uid = uid;
        self.password = passwoord;
        self.dict = @{@"key":@(22),@"key2":@"cool"};
    }
    return self;
}
@end
