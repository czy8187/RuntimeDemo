//
//  ViewController.m
//  RuntimeDemo
//
//  Created by hhsofta on 2018/6/6.
//  Copyright © 2018年 hhsofta. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import <objc/runtime.h>
#import "Person+mult.h"

@interface ViewController ()

@property(nonatomic, strong) Person *person;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.person = [[Person alloc] init];
    self.person.name = @"Tom";
    NSLog(@"%@",self.person.name);
}
- (IBAction)onChange:(UIButton *)sender {
    
    [self changeVarName];
//    [self exchangedMethed];
//    [self addMethed];
    
}
- (IBAction)onTest:(UIButton *)sender {
    //1
    NSLog(@"%@",self.person.name);
    
    //2
//    [self.person fristMethod];
    
    //3
//    if ([[self person] respondsToSelector:@selector(run:)]) {
//        [[self person] performSelector:@selector(run:) withObject:@"100 miles"];
//    }else{
//        NSLog(@"要添加的方法没有实现！！");
//    }
    
    //4
//    self.person.nick = @"Cat";
//    NSLog(@"%@",self.person.nick);
    
}
#pragma mark -  1.使用runtime改变实例变量的值
- (void)changeVarName{
    
    //获取实例变量列表
    unsigned int count = 0;
    Ivar *ivarList = class_copyIvarList([self.person class], &count);
    
    //遍历
    for (int i = 0; i < count; i++) {
        Ivar *myIvar = &ivarList[i];
        const char *ivarName = ivar_getName(*myIvar);
        
        //转化一下
        if ([[NSString stringWithUTF8String:ivarName] isEqualToString:@"_name"]) {
            //更改值
            object_setIvar(self.person, *myIvar, @"Jerry");
        }
    }
}
#pragma mark -  2.使用runtime交换实例方法*(method_exchangeImplementations)
- (void)exchangedMethed {
    //获取方法
    Method m1 = class_getInstanceMethod([self.person class], @selector(fristMethod));
    Method m2 = class_getInstanceMethod([self.person class], @selector(secondMethod));
    
    //交换
    method_exchangeImplementations(m1, m2);
}
#pragma mark - 3.使用runtime动态添加方法
- (void)addMethed {
    // "v@:@" v表示void，@表示id, :表示 SEL
    class_addMethod([self.person class], @selector(run:), (IMP)runMethod, "v@:@");
    
}
void runMethod(id self, SEL _cmd, NSString *miles){
    NSLog(@"%@",miles);
}

- (void)run:(id)sender {
    
}
#pragma mark - 4.使用runtime给分类扩展属性(请参考：Person+mult.m)




@end
