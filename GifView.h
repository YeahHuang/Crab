//
//  GifView.h
//  HelloTabBarController
//
//  Created by 黄霄 on 16/4/21.
//  Copyright © 2016年 GeekBand. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ImageIO/ImageIO.h>

@interface GifView : UIView {
	CGImageSourceRef gif;			// 这是展示的gif
	NSDictionary *gifProperties;	// 这是gif属性
	size_t index;					// 表示现在正在显示的帧数
	size_t count;					// 表示gif的帧数和
	NSTimer *timer;					// 这个NSTimer类有时间间隔、是否重复、动作等选项，方便调整gif播放的效果。
}

- (id)initWithFrame:(CGRect)frame filePath:(NSString *)_filePath; // 从外地文件读取
- (id)initWithFrame:(CGRect)frame data:(NSData *)_data; 		  // 从本工程资源读取， 本实验中最后只用了这种方法

@end
