//
//  APPdfLabel.h
//  iPhonePDF
//
//  Created by allamaprabhu on 11/27/14.
//
//

#import <Foundation/Foundation.h>
#import "APPdfView.h"

typedef enum _APTextAlignment{
    APTextAlignmentCentre = 0,
    APTextAlignmentLeft,
    APTextAlignmentRight
}APTextAlignment;

@interface APPdfLabel : APPdfView
{
    
}
@property (nonatomic)APTextAlignment alignment;
@property (nonatomic,retain)NSString *text;
@property (nonatomic,retain)UIFont *font;

@end
