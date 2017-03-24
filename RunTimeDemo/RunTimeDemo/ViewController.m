//
//  ViewController.m
//  RunTimeDemo
//
//  Created by huangshan on 2017/2/14.
//  Copyright © 2017年 huangshan. All rights reserved.
//

#import "ViewController.h"

#import <objc/runtime.h>

#import "RumTimeObject.h"

#import "Person.h"

#import "ExtendPerson.h"

#import "UIViewController+A.h"

#import "UIViewController+B.h"

@interface ViewController ()

@end

@implementation ViewController

//- (void)viewWillAppear:(BOOL)animated {
//    
//    [super viewWillAppear:animated];
//    NSLog(@"aaalalalalal");
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self test3];
    
}

- (void)test3 {
    
    Person *person = [[Person alloc] init];
    
    [person addPerson:@"a"];
    
}

- (void)test2 {
    
    ExtendPerson *exPerson = [[ExtendPerson alloc] init];
    
    [exPerson addPerson:@"a"];
    
}

- (void)test1 {

    
    unsigned int count;
    
    
    //获得属性的列表，只是获得property的属性的值，不管是共有的还是私有的
    objc_property_t *propertyList = class_copyPropertyList([RumTimeObject class], &count);
    
    for (unsigned int i = 0; i < count; i ++) {
        
        const char *propertyName = property_getName(propertyList[i]);
        
        NSLog(@"property--------%@", [NSString stringWithUTF8String:propertyName]);
        
        /** 打印结果：
         2017-02-14 14:46:05.658 RunTimeDemo[43231:1286291] property--------name
         2017-02-14 14:46:05.658 RunTimeDemo[43231:1286291] property--------age
         2017-02-14 14:46:05.659 RunTimeDemo[43231:1286291] property--------arr
         2017-02-14 14:46:05.659 RunTimeDemo[43231:1286291] property--------dic
         */
    }
    
    //获得方法的列表
    
    Method *methodList = class_copyMethodList([RumTimeObject class], &count);
    
    for (unsigned int i = 0; i < count; i ++) {
        
        Method method = methodList[i];
        
        NSLog(@"method--------%@", NSStringFromSelector(method_getName(method)));
        
        /** 打印结果
         2017-02-14 14:46:05.659 RunTimeDemo[43231:1286291] method--------eat
         2017-02-14 14:46:05.660 RunTimeDemo[43231:1286291] method--------food
         2017-02-14 14:46:05.660 RunTimeDemo[43231:1286291] method--------age
         2017-02-14 14:46:05.661 RunTimeDemo[43231:1286291] method--------setAge:
         2017-02-14 14:46:05.661 RunTimeDemo[43231:1286291] method--------arr
         2017-02-14 14:46:05.662 RunTimeDemo[43231:1286291] method--------setArr:
         2017-02-14 14:46:05.663 RunTimeDemo[43231:1286291] method--------dic
         2017-02-14 14:46:05.663 RunTimeDemo[43231:1286291] method--------setDic:
         2017-02-14 14:46:05.664 RunTimeDemo[43231:1286291] method--------.cxx_destruct
         2017-02-14 14:46:05.664 RunTimeDemo[43231:1286291] method--------name
         2017-02-14 14:46:05.665 RunTimeDemo[43231:1286291] method--------setName:
         
         */
    }
    
    //获得成员变量，不管是property还是全局的变量
    Ivar *ivarList = class_copyIvarList([RumTimeObject class], &count);
    
    for (unsigned int i = 0; i < count; i ++) {
        
        Ivar myIvar = ivarList[i];
        
        const char *ivarName = ivar_getName(myIvar);
        
        NSLog(@"ivar--------%@", [NSString stringWithUTF8String:ivarName]);
        
        /** 打印结果
         2017-02-14 14:46:05.665 RunTimeDemo[43231:1286291] ivar--------page
         2017-02-14 14:46:05.726 RunTimeDemo[43231:1286291] ivar--------cardId
         2017-02-14 14:46:05.726 RunTimeDemo[43231:1286291] ivar--------_name
         2017-02-14 14:46:05.726 RunTimeDemo[43231:1286291] ivar--------_age
         2017-02-14 14:46:05.727 RunTimeDemo[43231:1286291] ivar--------_arr
         2017-02-14 14:46:05.727 RunTimeDemo[43231:1286291] ivar--------_dic
         */
    }
    
    //还有的获得协议的列表
    
    //class_copyPropertyList(<#__unsafe_unretained Class cls#>, <#unsigned int *outCount#>)
    
    

}

//+ (void)load {
//
//    static dispatch_once_t onceToken;
//    
//    dispatch_once(&onceToken, ^{
//        
//        SEL systemWillAppear = @selector(viewWillAppear:);
//        
//        SEL swizzWillAppear = @selector(swizz_viewWillAppear:);
//        
//        Method systemMethod = class_getInstanceMethod([self class], systemWillAppear);
//        
//        Method swizzMethod = class_getInstanceMethod([self class], swizzWillAppear);
//        
//        BOOL isAdd = class_addMethod(self, systemWillAppear, method_getImplementation(swizzMethod), method_getTypeEncoding(swizzMethod));
//        
//        if (isAdd){
//        
//            //如果成功，说明类中不存在这个方法的实现
//            //替换方法
//            
//            class_replaceMethod(self, swizzWillAppear, method_getImplementation(systemMethod), method_getTypeEncoding(systemMethod));
//            
//        } else {
//        
//            method_exchangeImplementations(systemMethod, swizzMethod);
//        }
//
//        
//    });
//}

- (void)swizz_viewWillAppear:(BOOL)animation {

    NSLog(@"交换方法啦啦啦");
    
    [self swizz_viewWillAppear:animation];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
