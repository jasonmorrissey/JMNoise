//  Created by Jason Morrissey

#import "DemoViewController.h"
#import "UIView+JMNoise.h"

@interface DemoViewController()
@end

@implementation DemoViewController

-(void)loadView;
{
    [super loadView];
    self.view.backgroundColor = [UIColor blackColor];

    // Create a view/button/label/control as usual
    UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:@"Test Button" forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 200., 50.);
    button.center = CGPointMake(CGRectGetWidth(self.view.bounds) / 2, CGRectGetHeight(self.view.bounds) / 2);
    [self.view addSubview:button];

    // This is all you need for a noise texture
    [button applyNoise];
}

@end
