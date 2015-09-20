//
//  UIImage+Util.m
//  Prowlist
//
//  Created by Sebastian Romero on 13/06/15.
//  Copyright (c) 2015 Maachi. All rights reserved.
//

#import "UIImage+Util.h"

@implementation UIImage (Util)


- (UIImage *)imageWithColor:(UIColor *)color
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, self.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextClipToMask(context, rect, self.CGImage);
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


- (NSString *) localImage:(NSString *)imageNamed {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    NSString *dataPath = [NSString stringWithFormat:@"%@/%@", [documentsPath stringByAppendingPathComponent:@"/Assets"], imageNamed];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:dataPath]){
        return dataPath;
    } else {
        return nil;
    }
}


- (NSString *) storedImageInDisk:(NSString *)imageNamed {
    NSData *pngData = UIImagePNGRepresentation(self);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    
    NSString *dataPath = [documentsPath stringByAppendingPathComponent:@"/Assets"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
        [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:nil];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"Assets/%@", imageNamed]];
    NSLog(@"%@", filePath);
    [pngData writeToFile:filePath atomically:YES];
    [NSData dataWithContentsOfFile:filePath];
    return filePath;
}


- (UIImage *) resizeToSize:(CGSize) newSize cropWithRect:(CGRect) cropRect {
    CGContextRef context;
    CGImageRef imageRef;
    CGSize inputSize;
    UIImage* outputImage = nil;
    CGFloat scaleFactor, width;
    
    // resize, maintaining aspect ratio:
    
    inputSize = self.size;
    scaleFactor = newSize.height / inputSize.height;
    width = roundf( inputSize.width * scaleFactor );
    
    if ( width > newSize.width ) {
        scaleFactor = newSize.width / inputSize.width;
        newSize.height = roundf( inputSize.height * scaleFactor );
    } else {
        newSize.width = width;
    }
    
    UIGraphicsBeginImageContext( newSize );
    
    context = UIGraphicsGetCurrentContext();
    CGContextDrawImage( context, CGRectMake( 0, 0, newSize.width, newSize.height ), self.CGImage );
    outputImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    inputSize = newSize;
    
    // constrain crop rect to legitimate bounds
    if ( cropRect.origin.x >= inputSize.width || cropRect.origin.y >= inputSize.height ) return outputImage;
    if ( cropRect.origin.x + cropRect.size.width >= inputSize.width ) cropRect.size.width = inputSize.width - cropRect.origin.x;
    if ( cropRect.origin.y + cropRect.size.height >= inputSize.height ) cropRect.size.height = inputSize.height - cropRect.origin.y;
    
    // crop
    if ( ( imageRef = CGImageCreateWithImageInRect( outputImage.CGImage, cropRect ) ) ) {
        outputImage = [[UIImage alloc] initWithCGImage: imageRef];
        CGImageRelease( imageRef );
    }
    
    return outputImage;
}


- (UIImage *)fixOrientationOfImage {
    
    if (self.imageOrientation == UIImageOrientationUp) return self;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}



- (UIImage*)resizeImage:(CGSize)toSize
{
    UIImage *result = self;
    CGSize sourceSize = self.size;
    CGSize targetSize = toSize;
    
    BOOL needsRedraw = NO;
    
    // Check if width of source image is greater than width of target image
    // Calculate the percentage of change in width required and update it in toSize accordingly.
    
    if (sourceSize.width > toSize.width) {
        
        CGFloat ratioChange = (sourceSize.width - toSize.width) * 100 / sourceSize.width;
        
        toSize.height = sourceSize.height - (sourceSize.height * ratioChange / 100);
        
        needsRedraw = YES;
    }
    
    // Now we need to make sure that if we chnage the height of image in same proportion
    // Calculate the percentage of change in width required and update it in target size variable.
    // Also we need to again change the height of the target image in the same proportion which we
    /// have calculated for the change.
    
    if (toSize.height < targetSize.height) {
        
        CGFloat ratioChange = (targetSize.height - toSize.height) * 100 / targetSize.height;
        
        toSize.height = targetSize.height;
        toSize.width = toSize.width + (toSize.width * ratioChange / 100);
        
        needsRedraw = YES;
    }
    
    // To redraw the image
    
    if (needsRedraw) {
        UIGraphicsBeginImageContext(toSize);
        [self drawInRect:CGRectMake(0.0, 0.0, toSize.width, toSize.height)];
        result = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    // Return the result
    
    return result;
}


@end
