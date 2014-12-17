//
//  PDFAppDelegate.m
//  PDF
//
//  Created by Masashi Ono on 09/10/06.
//  Copyright Masashi Ono 2009. All rights reserved.
//

#import "PDFAppDelegate.h"
#import "PDFViewController.h"
#import "APPdfViewController.h"
#import "hpdf.h"
#import "APPdfView.h"

#import "NSIndexPath+Pdf.h"
@implementation PDFAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(UIApplication *)application
{
    window.rootViewController = [[[APPdfViewController alloc] init] autorelease];
    window.backgroundColor = [UIColor redColor];
    [window makeKeyAndVisible];

}


- (void)dealloc
{
    [viewController release];
    [window release];
    [super dealloc];
}


@end
