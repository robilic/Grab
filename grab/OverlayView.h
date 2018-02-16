//
//  OverlayView.h
//  Grab
//
//  Created by Robert on 8/31/12.
//  Copyright (c) 2012 Robert. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface OverlayView : NSView {
//  NSPoint selectionRectOrigin;
//  CGSize selectionRectSize;
  NSRect selectionRect;
  CGImageRef screenShotImage;
  
  bool isDragging, isCapturing;
}

- (void) saveCGImage:(CGImageRef)image;
- (void) CGImageWriteToFile:(CGImageRef)image filePath:(NSString*)path;
- (void) captureSelection;

@property bool isDragging, isCapturing;

@end
