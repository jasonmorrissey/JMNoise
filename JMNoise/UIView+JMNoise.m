//  Created by Jason Morrissey

#import <QuartzCore/QuartzCore.h>
#import "UIView+JMNoise.h"
#include <stdlib.h>

#define kNoiseTileDimension 100
#define kNoiseIntensity 100
#define kNoiseDefaultOpacity 0.5

@interface NoiseLayer : CALayer
- (UIImage *) noiseTileImage;
@end

@implementation NoiseLayer

static UIImage * JMNoiseImage;

- (void)setFrame:(CGRect)frame;
{
    [super setFrame:frame];
    [self setNeedsDisplay];
}

- (void)drawPixelInContext:(CGContextRef)context point:(CGPoint)point width:(CGFloat)width opacity:(CGFloat)opacity;
{
    CGColorRef fillColor = [UIColor colorWithWhite:0. alpha:opacity].CGColor;
    CGContextSetFillColor(context, CGColorGetComponents(fillColor));
    CGRect pointRect = CGRectMake(point.x - (width/2), point.y - (width/2), width, width);
    CGContextFillEllipseInRect(context, pointRect);
}

- (UIImage *)noiseTileImage;
{
    if (!JMNoiseImage)
    {
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGContextRef context = CGBitmapContextCreate(nil,kNoiseTileDimension,kNoiseTileDimension,8,0,
                                                     colorSpace,kCGImageAlphaPremultipliedLast);
        CFRelease(colorSpace);

        for (int i=0; i<(kNoiseTileDimension * kNoiseIntensity); i++)
        {
            int x = arc4random() % kNoiseTileDimension;
            int y = arc4random() % kNoiseTileDimension;
            int opacity = arc4random() % 100;
            [self drawPixelInContext:context point:CGPointMake(x, y) width:0.5 opacity:(opacity / 100.)]; 
        }

        CGImageRef imageRef = CGBitmapContextCreateImage(context);
        CGContextRelease(context);
        JMNoiseImage = [[UIImage alloc] initWithCGImage:imageRef];
    }
    return JMNoiseImage;
}

- (void)drawInContext:(CGContextRef)ctx;
{
    UIGraphicsPushContext(ctx);
    [[self noiseTileImage] drawAsPatternInRect:self.bounds];
    UIGraphicsPopContext();
}

@end


@implementation UIView (JMNoise)

- (void)applyNoiseWithOpacity:(CGFloat)opacity atLayerIndex:(NSUInteger) layerIndex;
{
    NoiseLayer * noiseLayer = [[[NoiseLayer alloc] init] autorelease];
    [noiseLayer setFrame:self.bounds];
    noiseLayer.masksToBounds = YES;
    noiseLayer.opacity = opacity;
    [self.layer insertSublayer:noiseLayer atIndex:layerIndex];
}

- (void)applyNoiseWithOpacity:(CGFloat)opacity;
{
    [self applyNoiseWithOpacity:opacity atLayerIndex:0];
}

- (void)applyNoise;
{
    [self applyNoiseWithOpacity:kNoiseDefaultOpacity];
}

@end
