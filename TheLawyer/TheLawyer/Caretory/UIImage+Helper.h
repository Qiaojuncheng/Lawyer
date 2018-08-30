//
//  UIImage+Helper.h
//  WuKong
//
//  Created by 赵耀 on 16/4/25.
//  Copyright © 2016年 weifengou. All rights reserved.
//



@interface UIImage (Helper)

/*
 *颜色这转为图片
 */
+(UIImage *)ImageForColor:(UIColor *)color;
/*
 *模糊图片
 */
+(UIImage *)blurryImage:(UIImage *)image
          withBlurLevel:(CGFloat)blur;
/* blur the current image with a box blur algoritm */
- (UIImage*)drn_boxblurImageWithBlur:(CGFloat)blur;

/* blur the current image with a box blur algoritm and tint with a color */
- (UIImage*)drn_boxblurImageWithBlur:(CGFloat)blur withTintColor:(UIColor*)tintColor;

+(UIImage *)setImgNameBianShen:(NSString *)Img;

/* 图片大小 */
- (UIImage *)imageByScalingToSize:(CGSize)targetSize;
/*
 *获取图片某个点的RGBA值
 */
+(NSMutableArray *)getImagePixel:(UIImage *)image point:(CGPoint)apoint;

@end
