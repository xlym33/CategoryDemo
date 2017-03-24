//
//  Person+A.m
//  RunTimeDemo
//
//  Created by huangshan on 2017/3/24.
//  Copyright © 2017年 huangshan. All rights reserved.
//

#import "Person+A.h"

#import <objc/runtime.h>

@implementation Person (A)

+ (void)load
{
    Method originalMethod = class_getInstanceMethod(self, @selector(addPerson:));
    Method swizzledMethod = class_getInstanceMethod(self, @selector(a_addPerson:));
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

- (void)a_addPerson:(NSString *)a {
        
    NSLog(@"A类里面~~~~~~%@", self);

    [self a_addPerson:a];
    
}

@end
