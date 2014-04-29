//
//  SingletonOld.m
//  SingletonTest
//
//  Created by dota.kobayashi on 2014/04/29.
//  Copyright (c) 2014年 dota.kobayashi. All rights reserved.
//
//  GDC以前に利用されてたシングルトン記述
//  http://www.toyship.org/archives/1770
//  http://d.hatena.ne.jp/nakamura001/20120306/1331042871
//  http://blog.syuhari.jp/archives/2178
//

#import "SingletonOld.h"

static SingletonOld *sharedInstance = nil;

@implementation SingletonOld


// シングルトンとスレッドセーフかは、また別の問題？
// スレッドセーフじゃないデザインも確かに有りますが
// マルチスレッドな場面が有り得るiOS向けの話なので
// スレッドセーフという安全の側に倒した記述にして有ります。
+ (SingletonOld *) sharedInstance
{
    // @synchronized(self) {} を行う事で、selfに対する処理が {} の間は別のスレッドから行えないようになります。
	@synchronized(self)     {
		if (!sharedInstance) {
            sharedInstance = [[self alloc] init];
        } else {
            NSLog(@"SingletonOld sharedInstance 存在するよ");
        }
	}
    return sharedInstance;
}

+ (id)allocWithZone:(NSZone *)zone {
	
	@synchronized(self) {
		if (sharedInstance == nil) {
            NSLog(@"SingletonOld alloc 初めて呼び出された");
			sharedInstance = [super allocWithZone:zone];
			return sharedInstance; // 初回のallocationで代入して返す
			
		}
	}
    NSLog(@"SingletonOld alloc ２回目以降だよ");
	return nil; // ２回目以降はnilを返す
}

- (id)copyWithZone:(NSZone *)zone{
	NSLog(@"SingletonOld copy");
    return self;
}

-(id)init
{
    self = [super init];
    if (self != nil)
        NSLog(@"SingletonOld init");
    
    return self;
    
}

@end
