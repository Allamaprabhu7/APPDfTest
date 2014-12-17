//
//  APPDFImageView.m
//  iPhonePDF
//
//  Created by allamaprabhu on 12/10/14.
//
//

#import "APPDFImageView.h"
#import "APPdfContext.h"
#import "hpdf.h"

@implementation APPDFImageView
- (instancetype)init {
    return [self initWithImage:nil];
}
- (instancetype)initWithImage:(NSString *)imagePath
{
    self = [super init];
    if (self) {
        self.imagePath = imagePath;
        self.borderEnabled = YES;
    }
    return self;
}
- (void)dealloc
{
    self.imagePath = nil;
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
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:self.imagePath]) {
        HPDF_Page page = HPDF_List_ItemAt(pdf->page_list,(HPDF_UINT)self.pageNo);
        const char *pathCString = [self.imagePath cStringUsingEncoding:NSASCIIStringEncoding];
        HPDF_Image image = HPDF_LoadJpegImageFromFile(pdf, pathCString);
        if (!image) {
            image = HPDF_LoadPngImageFromFile(pdf, pathCString);
        }
        HPDF_Point currentPoint = [self getRelativeCoordinates];
        CGFloat imageWidth=self.frame.size.width;
        CGFloat imageHeight=self.frame.size.height;
        if (image) {
            HPDF_Page_DrawImage(page, image, currentPoint.x, currentPoint.y,imageWidth,imageHeight);
        }
    }


}
@end
