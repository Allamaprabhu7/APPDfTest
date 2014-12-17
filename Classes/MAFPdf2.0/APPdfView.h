//
//  APPdfView.h
//  iPhonePDF
//
//  Created by allamaprabhu on 11/28/14.
//
//

#import <Foundation/Foundation.h>
#import "hpdf.h"

@interface APPdfView : NSObject
{
    CGRect _frame;
    HPDF_Doc context;
    APPdfView *_superView;
    NSMutableArray *_subViews;
    BOOL _isDrawn;
}
@property (nonatomic) BOOL rootView;
@property (nonatomic,assign)CGRect frame;
@property (nonatomic)BOOL borderEnabled;
@property (nonatomic)NSUInteger lineWidth;
@property (nonatomic,retain)UIColor *strokeColor;
@property (nonatomic) NSUInteger pageNo;
@property (nonatomic,retain) APPdfView *superView;
@property (nonatomic,retain) NSMutableArray *subViews;
@property (nonatomic,retain) UIColor *backgroundColor;

- (void)drawRect;
- (void)setNeedsDisplay;
- (void)addSubView:(APPdfView *)view;
- (void)removeFromSuperView;
- (HPDF_Point)getRelativeCoordinates;
@end
