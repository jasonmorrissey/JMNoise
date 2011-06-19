//  Created by Jason Morrissey

#import <UIKit/UIKit.h>

@interface UIView (JMNoise)

- (void)applyNoise;

- (void)applyNoiseWithOpacity:(CGFloat)opacity atLayerIndex:(NSUInteger) layerIndex;
- (void)applyNoiseWithOpacity:(CGFloat)opacity;

@end
