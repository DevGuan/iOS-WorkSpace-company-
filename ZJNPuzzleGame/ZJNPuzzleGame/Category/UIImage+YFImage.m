//
//  UIImage+YFImage.m
//  自家扩展
//
//  Created by  张亚飞 on 16/7/16.
//  Copyright © 2016年  张亚飞. All rights reserved.
//

#import "UIImage+YFImage.h"

@implementation UIImage (YFImage)
+ (UIImage *)clipImageWithImage:(UIImage *)image {
    CGFloat imageWidth = image.size.width;
    CGFloat imageHeight = image.size.height;
    CGFloat minSize = MIN(imageHeight, imageWidth);
    CGRect newRect = CGRectMake(0, 0, minSize, minSize);
    CGImageRef ImageRef = CGImageCreateWithImageInRect(image.CGImage, newRect);
    UIGraphicsBeginImageContext(newRect.size);
    CGContextRef ref = UIGraphicsGetCurrentContext();
    CGContextDrawImage(ref, newRect, ImageRef);
    UIImage *imageB = [UIImage imageWithCGImage:ImageRef];
    UIGraphicsEndImageContext();
    return imageB;
}

+ (UIImage *)clipImageWithImage:(UIImage *)image withFrame:(CGRect)frame {
    CGRect newRect = frame;
    CGImageRef ImageRef = CGImageCreateWithImageInRect(image.CGImage, newRect);
    UIGraphicsBeginImageContext(newRect.size);
    CGContextRef ref = UIGraphicsGetCurrentContext();
    CGContextDrawImage(ref, newRect, ImageRef);
    UIImage *imageB = [UIImage imageWithCGImage:ImageRef];
    UIGraphicsEndImageContext();
    return imageB;
}

+ (NSMutableArray *)clipImageWithImage:(UIImage *)image withConuntM:(int)countM withCountN:(int)countN {
    NSMutableArray *array = [NSMutableArray array];
    CGFloat imageSizeWidth = image.size.width / (CGFloat)countM;
    CGFloat imageSizeHeigh = image.size.height / (CGFloat)countN;
    for (int i = 0; i < countM; i++) {
        for (int j = 0; j < countN; j++) {
            CGRect newRect = CGRectMake((CGFloat)j * imageSizeWidth, (CGFloat)i * imageSizeHeigh, imageSizeWidth, imageSizeHeigh);
            CGImageRef ImageRef = CGImageCreateWithImageInRect(image.CGImage, newRect);
            UIGraphicsBeginImageContext(newRect.size);
            CGContextRef ref = UIGraphicsGetCurrentContext();
            CGContextDrawImage(ref, newRect, ImageRef);
            UIImage *imageB = [UIImage imageWithCGImage:ImageRef];
            UIGraphicsEndImageContext();
            [array addObject:imageB];
        }
    }
    return array;;
}





@end
