## UIView+JMNoise

This is a category on UIView that makes it very easy to add a noise texture to UIViews.  It's performed entirely using **Core Graphics** so it does not require any additional images to be used in your projects.

## How it looks

Here's an example of a UIButton with the `applyNoise` method applied:

<img src="http://alienblue.org/github/JMNoise.png" width=499 height=184 />

## Usage

To use the category, you just need to call `applyNoise` and that's it.

For example:

`[myView applyNoise]`

I've included a Demo project so that you can jump in and play around with it.

## Customization

If you need a little bit more control over how `applyNoise` operates, the following methods are also exposed for your convenience:

`applyNoiseWithOpacity:`

and

`applyNoiseWithOpacity:atLayerIndex:`

... to specify which layer you want to insert the noise.  That said, the category will attempt to figure out the best place to insert the noise. (eg. behind text in buttons).

## What about drawRects?

If you prefer to draw your noise layer manually within a `drawRect()`, you can invoke the `drawCGNoise` method.  For example:

    -(void)drawRect()
    {
        // draw background
        ...
        
        // draw noise texture
        [self drawCGNoise];
        
        // draw stuff over the noise texture
        ...
    }

Similarly, for more control over texture opacity, you can call:

`[self drawCGNoiseWithOpacity:]`

## Installation

All you need to do is import `UIView+JMNoise.h` and make sure that you have the **QuartzCore** framework linked to your target.

## License

The code used in JMNoise is BSD licensed, so you can freely use it in commercial applications.
