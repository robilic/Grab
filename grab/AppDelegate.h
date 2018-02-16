//
//  AppDelegate.h
//  Grab
//
//  Created by Robert on 8/31/12.
//  Copyright (c) 2012 Robert. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class PreferencesWindowController;

@interface AppDelegate : NSObject <NSApplicationDelegate> {
    PreferencesWindowController *preferencesWindow;
}

// - (IBAction)showPreferencesWindowController;

@property (assign) IBOutlet NSWindow *window;

@end
