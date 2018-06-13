//
//  Person+mult.m
//  RuntimeDemo
//
//  Created by hhsofta on 2018/6/6.
//  Copyright © 2018年 hhsofta. All rights reserved.
//

#import "Person+mult.h"
#import <objc/runtime.h>

@implementation Person (mult)

const char *name = "nick";

- (void) setNick:(NSString *)nick{
    
    objc_setAssociatedObject(self, &name, nick, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSString *) nick{
    return objc_getAssociatedObject(self, &name);
}
@end
