//
//  NSObject+__DyInjectSwizzle.m
//  DyInjectService
//
//  Created by Shawn on 2016/10/19.
//  Copyright © 2016年 OneStore. All rights reserved.
//

#import "NSObject+__DyInjectSwizzle.h"
#import <objc/runtime.h>

@implementation NSObject (__DyInjectSwizzle)

+ (BOOL)___overrideMethod:(SEL)origSel withMethod:(SEL)altSel
{
    Method origMethod =class_getInstanceMethod(self, origSel);
    if (!origMethod) {
        return NO;
    }
    
    Method altMethod =class_getInstanceMethod(self, altSel);
    if (!altMethod) {
        return NO;
    }
    
    method_setImplementation(origMethod, class_getMethodImplementation(self, altSel));
    return YES;

}

+ (BOOL)___overrideClassMethod:(SEL)origSel withClassMethod:(SEL)altSel
{
    Class c = object_getClass((id)self);
    return [c ___overrideMethod:origSel withMethod:altSel];
}

+ (BOOL)___exchangeMethod:(SEL)origSel withMethod:(SEL)altSel
{
    Method origMethod =class_getInstanceMethod(self, origSel);
    if (!origMethod) {
        return NO;
    }
    
    Method altMethod =class_getInstanceMethod(self, altSel);
    if (!altMethod) {
        return NO;
    }
    
    method_exchangeImplementations(class_getInstanceMethod(self, origSel),class_getInstanceMethod(self, altSel));
    
    return YES;
}

+ (BOOL)___exchangeClassMethod:(SEL)origSel withClassMethod:(SEL)altSel
{
    Class c = object_getClass((id)self);
    return [c ___exchangeMethod:origSel withMethod:altSel];
}

@end
