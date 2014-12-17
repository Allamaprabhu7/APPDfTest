//
//  PDFAppDelegate.h
//  PDF
//
//  Created by Masashi Ono on 09/10/06.
//  Copyright Masashi Ono 2009. All rights reserved.
//
    
#import <UIKit/UIKit.h>

@class PDFViewController;
@class SampelVC;

@interface PDFAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    SampelVC *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

