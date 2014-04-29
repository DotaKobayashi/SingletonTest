//
//  Singleton2.m
//  SingletonTest
//
//  Created by dota.kobayashi on 2014/04/29.
//  Copyright (c) 2014年 dota.kobayashi. All rights reserved.
//
//  alloc/init → new
//

#import "Singleton2.h"

static Singleton2* sharedInstance;

@implementation Singleton2

+ (Singleton2*)sharedInstance{
	
	static dispatch_once_t once;
	dispatch_once( &once, ^{
        NSLog(@"Singleton2 1回しか通らない");
		[self new];
	});
    
	return sharedInstance;
	
}

+ (id)allocWithZone:(NSZone *)zone {
	
	__block id ret = nil;
	
	static dispatch_once_t once;
	dispatch_once( &once, ^{
        NSLog(@"Singleton2 alloc");
		sharedInstance = [super allocWithZone:zone];
		ret = sharedInstance;
	});
	
	return  ret;
	
}

- (id)copyWithZone:(NSZone *)zone{
    NSLog(@"Singleton2 copy");
    return self;
}

- (id)init
{
    self = [super init];
    if (self != nil)
        NSLog(@"Singleton2 init");
    
    return self;
}

@end
