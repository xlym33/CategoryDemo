//
//  Person+B.m
//  RunTimeDemo
//
//  Created by huangshan on 2017/3/24.
//  Copyright © 2017年 huangshan. All rights reserved.
//

#import "Person+B.h"

#import <objc/runtime.h>

@implementation Person (B)

+ (void)load
{
    Method originalMethod = class_getInstanceMethod(self, @selector(addPerson:));
    Method swizzledMethod = class_getInstanceMethod(self, @selector(b_addPerson:));
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

- (void)b_addPerson:(NSString *)a {
    
    NSLog(@"B类里面~~~~~~%@", self);
    
    [self b_addPerson:a];
    
}

@end
