//
//  NSIndex+Pdf.m
//  iPhonePDF
//
//  Created by allamaprabhu on 6/1/14.
//
//

#import "NSIndexPath+Pdf.h"

@implementation NSIndexPath (IndedxPath_PDF)
+(NSIndexPath *)indexPathForPage:(NSUInteger)page section:(NSUInteger)sec row:(NSUInteger)row
{
    const NSUInteger tree[3] = {page,sec,row};
    return [NSIndexPath indexPathWithIndexes:tree length:3];
}

- (NSUInteger)page
{
    return [self indexAtPosition:0];
}

- (NSUInteger)sec
{
    return [self indexAtPosition:1];
}

- (NSUInteger)row
{
    return [self indexAtPosition:2];
}
@end
