//
//  APPdfView.m
//  iPhonePDF
//
//  Created by allamaprabhu on 11/28/14.
//
//

#import "APPdfView.h"
#import "APPdfContext.h"

@interface APPdfView ()

@end

@implementation APPdfView
@synthesize frame = _frame;
@synthesize superView = _superView;
@synthesize subViews = _subViews;
@synthesize pageNo;
@synthesize lineWidth;
@synthesize strokeColor;
@synthesize backgroundColor;

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.frame = CGRectNull;
        self.superView = nil;
        self.subViews = [NSMutableArray array];
        self.borderEnabled = YES;
        self.lineWidth = 5.0;
        self.strokeColor = [UIColor redColor];
        self.pageNo = 0;
        self.rootView = NO;
        _isDrawn = NO;
//        self.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor colorWithRed:0.980 green:0.980 blue:0.980 alpha:1.0];
    }
    return self;
}

- (void)dealloc
{
    self.superView = nil;
    self.subViews = nil;
    [super dealloc];
}

- (void)setNeedsDisplay
{
    [self drawRect];
    for (APPdfView *view in self.subViews) {
        [view setNeedsDisplay];
    }
}

- (void)drawRect
{
    if (self.borderEnabled)
    {
        HPDF_Point currPt = [self getRelativeCoordinates];
        
        CGRect rect = CGRectMake(currPt.x, currPt.y, self.frame.size.width, self.frame.size.height);
        [self fillRectanlge:rect];
        [self drawRectangle:rect];
        
        _isDrawn = YES;
    }
}

- (void)drawRectangle:(CGRect)rect
{
    HPDF_Doc pdf = AP_getCurrentPdfDoc();
    HPDF_UINT num = (unsigned int)self.pageNo;
    HPDF_Page page = HPDF_List_ItemAt(pdf->page_list, num);
    HPDF_REAL strokeWitdth = self.lineWidth;
    HPDF_Page_SetLineWidth(page, strokeWitdth);
    
    CGFloat r,g,b,a;
    [self.strokeColor getRed:&r green:&g blue:&b alpha:&a];
    HPDF_Page_SetRGBStroke(page, r, g, b);

    HPDF_Page_Rectangle(page,rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
    HPDF_Page_Stroke(page);
    HPDF_Page_SetRGBStroke(page, 0.0, 0.0, 0.0);

}

- (void)fillRectanlge:(CGRect)rect
{
    HPDF_Doc pdf = AP_getCurrentPdfDoc();
    HPDF_Page page = HPDF_List_ItemAt(pdf->page_list, (HPDF_UINT)self.pageNo);
    
    CGFloat r,g,b,a;
    [self.backgroundColor getRed:&r green:&g blue:&b alpha:&a];
    HPDF_Page_SetRGBFill(page, r, g, b);
    HPDF_Page_Rectangle(page, rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
    HPDF_Page_FillStroke(page);
    //Rest to normal
    HPDF_Page_SetRGBFill(page, 0.0, 0.0, 0.0);
    HPDF_Page_SetRGBStroke(page, 0.0, 0, 0);
}

- (void)addSubView:(APPdfView *)view
{
    view.superView = self;
    [self.subViews addObject:view];
    if (_isDrawn)
    {
        [view setNeedsDisplay];
    }
    
}

- (void)removeFromSuperView
{
    //TODO-Need to test this thorughly
    [self.superView.subViews removeObject:self];
    self.superView = nil;
    if (_isDrawn) {
        [self setNeedsDisplay];
    }
    
}

- (HPDF_Point)getRelativeCoordinates
{
    
    HPDF_Doc pdf = AP_getCurrentPdfDoc();
    HPDF_GetCurrentPage(pdf);
    HPDF_Page page;
    
    page = HPDF_List_ItemAt(pdf->page_list, (HPDF_UINT)self.pageNo);
    
    HPDF_REAL totalheight = HPDF_Page_GetHeight(page);
    HPDF_REAL relativeHeight = 0,relativeWidth = 0;
    HPDF_REAL currentX,currentY;
    CGRect parentFrame = CGRectNull;
    
    
    if (nil == self.superView)
    {
        //Root view
        currentX = self.frame.origin.x;
        currentY = totalheight - self.frame.origin.y;
    }
    else
    {
        APPdfView *superView = self.superView;
        while (superView)
        {
            parentFrame = superView.frame;
            if (nil == superView.superView) {
                relativeHeight = relativeHeight + (totalheight - parentFrame.origin.y);
            }
            else {
                relativeHeight = relativeHeight + parentFrame.origin.y;
            }
            
            relativeWidth = relativeWidth + parentFrame.origin.x;
            
            superView = superView.superView;
        }
        
        relativeWidth = relativeWidth + self.frame.origin.x;
        relativeHeight = relativeHeight + self.frame.origin.y;
        
        currentY = relativeHeight;
        currentX = relativeWidth;
    }
    HPDF_Point point;
    point.x = currentX;
    point.y = currentY;
    return point;
}
@end
