//
//  NSIndex+Pdf.h
//  iPhonePDF
//
//  Created by allamaprabhu on 6/1/14.
//
//

#import <Foundation/Foundation.h>

@interface NSIndexPath (IndedxPath_PDF)

@property(nonatomic,readonly) NSUInteger page;
@property(nonatomic,readonly) NSUInteger sec;
@property(nonatomic,readonly) NSUInteger row;

+(NSIndexPath *)indexPathForPage:(NSUInteger)page section:(NSUInteger)sec row:(NSUInteger)row;
@end