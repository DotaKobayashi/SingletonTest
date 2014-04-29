//
//  Singleton.m
//  SingletonTest
//
//  Created by dota.kobayashi on 2014/04/29.
//  Copyright (c) 2014年 dota.kobayashi. All rights reserved.
//
//  GDC導入後のシングルトン記述方法
//

#import "Singleton.h"

static Singleton* sharedInstance;

@implementation Singleton

+ (Singleton*)sharedInstance{
	
	static dispatch_once_t once;
	dispatch_once( &once, ^{
        NSLog(@"Singleton 1回しか通らない");
		[[self alloc] init];
	});
    
	return sharedInstance;
	
}

+ (id)allocWithZone:(NSZone *)zone {
	
	__block id ret = nil;
	
	static dispatch_once_t once;
	dispatch_once( &once, ^{
        NSLog(@"Singleton alloc");
		sharedInstance = [super allocWithZone:zone];
		ret = sharedInstance;
	});
	
	return  ret;
	
}

- (id)copyWithZone:(NSZone *)zone{
    NSLog(@"Singleton copy");
    return self;
}

- (id)init
{
    self = [super init];
    if (self != nil)
        NSLog(@"Singleton init");
    
    return self;
}

@end
