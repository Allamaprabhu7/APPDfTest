//
//  APPdfLabel.m
//  iPhonePDF
//
//  Created by allamaprabhu on 11/27/14.
//
//

#import "APPdfLabel.h"
#import "APPdfContext.h"

@implementation APPdfLabel
@synthesize alignment;
- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.alignment = APTextAlignmentCentre;
        self.borderEnabled = YES;
    }
    return self;
}
- (void)dealloc
{
    [super dealloc];
}

- (void)setNeedsDisplay
{
    [super setNeedsDisplay];
}

- (void)drawRect
{
    [super drawRect];
    
    
    HPDF_Doc pdf = AP_getCurrentPdfDoc();
    NSString *fontName = self.font.fontName;
    char *cFontName = (char *)[fontName cStringUsingEncoding:NSUTF8StringEncoding];
    HPDF_REAL fontSize = self.font.pointSize;
    HPDF_Font fontEn = HPDF_GetFont(pdf, cFontName, "StandardEncoding");
    unsigned char *str = (unsigned char *)[self.text cStringUsingEncoding:NSUTF8StringEncoding];
    
    HPDF_Page page;
    HPDF_UINT pageNo = (HPDF_UINT)self.pageNo;
    page = HPDF_List_ItemAt(pdf->page_list, pageNo);
    HPDF_Page_BeginText(page);
    HPDF_Page_SetFontAndSize(page, fontEn, fontSize);
    
    
    
    HPDF_Point currentPoint = [self getRelativeCoordinates];
    currentPoint.y = (currentPoint.y) + (self.frame.size.height - fontSize)/2.0;

    HPDF_REAL txtWidh = HPDF_Page_TextWidth(page, (const char *)str);
    switch (self.alignment)
    {
        case APTextAlignmentLeft:
        {
            currentPoint.x = currentPoint.x;
        }
            break;
        case APTextAlignmentCentre:
        {
            currentPoint.x = currentPoint.x + (self.frame.size.width - txtWidh)/2.0;
        }
            break;
        case APTextAlignmentRight:
        {
            currentPoint.x = currentPoint.x + self.frame.size.width - txtWidh;
        }
            break;
        default:
        {
            //Centre
            currentPoint.x = currentPoint.x + (self.frame.size.width - txtWidh)/2.0;
        }
            break;
    }
    
    HPDF_Page_TextOut(page, currentPoint.x, currentPoint.y, (char *)str);
    HPDF_Page_EndText(page);
}

@end
