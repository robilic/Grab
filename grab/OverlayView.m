//
//  OverlayView.m
//  Grab
//
//  Created by Robert on 8/31/12.
//  Copyright (c) 2012 Robert. All rights reserved.
//

#import "OverlayView.h"
#import "PreferencesWindowController.h"

@implementation OverlayView

@synthesize isDragging, isCapturing;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
      isCapturing = isDragging = NO;
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
	[NSGraphicsContext saveGraphicsState];

	if (isDragging && !isCapturing) {
      NSBezierPath *selection = [NSBezierPath bezierPathWithRect:selectionRect];
			NSColor *fill = [[NSColor blackColor] colorWithAlphaComponent:0.15f];
			[fill set];
			[selection fill];
      NSColor *selectionColor = [NSColor darkGrayColor];
      [selectionColor set];
      [selection setLineWidth:1.0f];
      [selection stroke];			
    }
    else {
      // NSLog(@"Not drawing anything");
    }

  [NSGraphicsContext restoreGraphicsState];

  if (isCapturing) {
		[self performSelector:@selector(captureSelection)
							 withObject:nil afterDelay:0.05];
	}
}

- (void) captureSelection {
	NSLog(@"saving screenshot");
	
	if (screenShotImage) {
		CGImageRelease(screenShotImage);
		screenShotImage = NULL;
	}
	
	screenShotImage = CGWindowListCreateImage(NSRectToCGRect(selectionRect), kCGWindowListOptionOnScreenOnly, kCGNullWindowID, kCGWindowImageDefault);
  
	[self saveCGImage:screenShotImage];
	isCapturing = NO;
	selectionRect.origin.x = selectionRect.origin.y = 0.0f;
	selectionRect.size = CGSizeZero;

}

- (BOOL)acceptsFirstResponder {
  return YES;
}

- (void) saveCGImage:(CGImageRef)image {
	// get the location of /Users/username/Documents
	// this will be user-specificable later
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  NSURL *saveToURL = [NSKeyedUnarchiver unarchiveObjectWithData:[defaults valueForKey:GRBFileSaveLocationKey]];
	NSString *screenShotFilePath = [saveToURL path];
  
  [self CGImageWriteToFile:image filePath:screenShotFilePath];
}

- (void) CGImageWriteToFile:(CGImageRef)image filePath:(NSString*)path {
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	time_t rawtime;
	struct tm *timeinfo;
	char buffer[80];
	
	// get the system time+date for parsing into the user-specified string
	time(&rawtime);
    timeinfo = localtime(&rawtime);
  strftime(buffer, 80, [[defaults objectForKey:GRBFileNameStringKey] cStringUsingEncoding:NSUTF8StringEncoding ], timeinfo);
	NSString *fName = [NSString stringWithCString:buffer encoding:NSUTF8StringEncoding];

	// add the file name to the path
    CFURLRef url = (CFURLRef)[[NSURL fileURLWithPath:path] URLByAppendingPathComponent:fName];

  CGImageDestinationRef destination = CGImageDestinationCreateWithURL(url, kUTTypePNG, 1, NULL);
  
  /*
   kUTTypePNG
   kUTTypeTIFF
   kUTTypeJPG
   kUTTypeGIF
   kUTTypeBMP
  */
  
  CGImageDestinationAddImage(destination, image, nil);
  
  if (!CGImageDestinationFinalize(destination)) {
    NSLog(@"Failed to write image to %@", path);
  }
  
  CFRelease(destination);
}

#pragma mark Events

- (void)mouseDown:(NSEvent *)theEvent {
  
  NSPoint p = [theEvent locationInWindow];
  selectionRect.origin = p;
  selectionRect.size = CGSizeZero;
}

- (void)mouseDragged:(NSEvent *)theEvent {
  NSPoint p2 = [theEvent locationInWindow];
	
  selectionRect.size = CGSizeMake(-(selectionRect.origin.x-p2.x), -(selectionRect.origin.y-p2.y));  
  isDragging = YES;
	
  [self setNeedsDisplay:YES];
}

- (void)mouseUp:(NSEvent *)theEvent {
  NSRect windowRect = [[self window] frame];
 
  selectionRect.origin.y = windowRect.size.height - selectionRect.origin.y;
  selectionRect.size.height = -selectionRect.size.height;
  
//  NSLog(@"selectionOrigin is %f, %f size is %f by %f", selectionRect.origin.x, selectionRect.origin.y, selectionRect.size.width, selectionRect.size.height);
    
  if (isDragging) {
    NSLog(@"About to take a picture...");
    isCapturing = YES;
  }
  
  // reset this stuff we don't need it anymore
  isDragging = NO;
  [self setNeedsDisplay:YES];
}

@end
