//
//  GifView.m
//  HelloTabBarController
//
//  Created by 黄霄 on 16/4/20.
//  Copyright © 2016年 GeekBand. All rights reserved.
//

#import "GifView.h"
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@implementation GifView


- (id)initWithFrame:(CGRect)frame filePath:(NSString *)_filePath{ 	// 从外地文件读取gif
    
    self = [super initWithFrame:frame];
    if (self) {
    	// 得到gif属性、gif、  和总帧数     
		gifProperties = [NSDictionary dictionaryWithObject:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:0] forKey:(NSString *)kCGImagePropertyGIFLoopCount]
													 forKey:(NSString *)kCGImagePropertyGIFDictionary] ;
		gif = CGImageSourceCreateWithURL((CFURLRef)[NSURL fileURLWithPath:_filePath], (CFDictionaryRef)gifProperties);
		count =CGImageSourceGetCount(gif);
		// 设置 播放的时间为 间隔0.12秒，使用play函数， 不断重复播放。 
		timer = [NSTimer scheduledTimerWithTimeInterval:0.12 target:self selector:@selector(play) userInfo:nil repeats:YES];
		[timer fire];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame data:(NSData *)_data{   			// 从本地文件读取gif，具体实现基本同上。
    self = [super initWithFrame:frame];
    if (self) {
        // 得到gif属性、gif、  和总帧数   
		gifProperties = [NSDictionary dictionaryWithObject:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:0] forKey:(NSString *)kCGImagePropertyGIFLoopCount] forKey:(NSString *)kCGImagePropertyGIFDictionary];
       gif = CGImageSourceCreateWithData((CFDataRef)_data, (CFDictionaryRef)gifProperties);
		count =CGImageSourceGetCount(gif);
		// 设置 播放的时间为 间隔0.12秒，使用play函数， 不断重复播放。
		timer = [NSTimer scheduledTimerWithTimeInterval:0.12 target:self selector:@selector(play) userInfo:nil repeats:YES];
		[timer fire];
    }
    return self;
}

-(void)play   // 相当于一个for循环
{
	index ++;						// 帧数+1
	index = index%count;			// 到头了就重复播放
	CGImageRef ref = CGImageSourceCreateImageAtIndex(gif, index, (CFDictionaryRef)gifProperties);// 通过帧数的到当下播放图片
	self.layer.contents = (__bridge id)ref; 
    CFRelease(ref);
}

-(void)removeFromSuperview		// 移除gif
{
	NSLog(@"removeFromSuperview");
	[timer invalidate];
	timer = nil;
	[super removeFromSuperview];
}

- (void)dealloc {				// 释放
    NSLog(@"dealloc");
	CFRelease(gif);
}
@end
