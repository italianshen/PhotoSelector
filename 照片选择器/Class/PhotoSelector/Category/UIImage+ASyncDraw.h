//
//  UIImage+ASyncDraw.h
//  照片选择器
//
//  Created by Danny on 2017/5/8.
//  Copyright © 2017年 Danny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ASyncDraw)


-(void)ddu_AsyncDrawImage:(CGSize)size bgColor:(UIColor *)bgColor isCorner:(BOOL)isRadius drawFinish:(void (^)(UIImage *image)) finish;


@end
