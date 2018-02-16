//
//  OverlayWindow.m
//  Grab
//
//  Created by Robert on 8/31/12.
//  Copyright (c) 2012 Robert. All rights reserved.
//

#import "OverlayWindow.h"

@implementation OverlayWindow

- (id)initWithContentRect:(NSRect)contentRect
                styleMask:(NSUInteger)windowStyle
                  backing:(NSBackingStoreType)bufferingType
                    defer:(BOOL)deferCreation
{
    // basically make a giant, see-through window that will
    // intercept mouse clicks and draw the selection box
    self = [super
            initWithContentRect:contentRect
            styleMask:NSBorderlessWindowMask
            backing:bufferingType
            defer:deferCreation];
    if (self)
    {
      [self setIgnoresMouseEvents:NO];
      [self setOpaque:NO];
      [self setBackgroundColor:[NSColor clearColor]];
    }
    return self;
}

@end
