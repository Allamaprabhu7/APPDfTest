//
//  APPDFImageView.h
//  iPhonePDF
//
//  Created by allamaprabhu on 12/10/14.
//
//

#import <Foundation/Foundation.h>
#import "APPdfView.h"

@interface APPDFImageView : APPdfView
{
    
}
@property (nonatomic,copy)NSString *imagePath;
- (instancetype)initWithImage:(NSString *)imagePath;
@end
