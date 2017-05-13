//
//  UIImage+ASyncDraw.m
//  照片选择器
//
//  Created by Danny on 2017/5/8.
//  Copyright © 2017年 Danny. All rights reserved.
//

#import "UIImage+ASyncDraw.h"

@implementation UIImage (ASyncDraw)

-(void)ddu_AsyncDrawImage:(CGSize)size bgColor:(UIColor *)bgColor isCorner:(BOOL)isRadius drawFinish:(void (^)(UIImage *image)) finish{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        
    
        //开启上下文
        UIGraphicsBeginImageContextWithOptions(size, YES, [UIScreen mainScreen].scale);
        
        //设置背景色
        [bgColor setFill];
        
        UIRectFill(rect);
        
        if (isRadius) {
            //路径
            UIBezierPath *path =[UIBezierPath bezierPathWithOvalInRect:rect];
            [path addClip];
        }
        
        [self drawInRect:rect];
        
        //获取图片
        UIImage *newImage =UIGraphicsGetImageFromCurrentImageContext();
        
        //结束上下文
        UIGraphicsEndImageContext();
        
        //异步返回绘制好的图片
        dispatch_async(dispatch_get_main_queue(), ^{
            finish(newImage);
        });
        
    });

}


@end
