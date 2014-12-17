//
//  APPdfContext.h
//  iPhonePDF
//
//  Created by allamaprabhu on 12/2/14.
//
//

#ifndef __iPhonePDF__APPdfContext__
#define __iPhonePDF__APPdfContext__

#include <stdio.h>
#include "hpdf.h"

typedef struct _AP_PDFService_userData {
    HPDF_Doc pdf;
    char *filePath;
    void *templatePtr;
} AP_PDFService_userData;


//TODO-Change the name
extern void PDFService_defaultErrorHandler1(HPDF_STATUS   error_no,
                                     HPDF_STATUS   detail_no,
                                     void         *user_data);

extern HPDF_Doc AP_getCurrentPdfDoc(void);

extern void AP_InitPdfContext(char *path);

extern void AP_AddPage();
extern void AP_savePdfAndCleanUp(char *path,HPDF_Doc pdf);
#endif /* defined(__iPhonePDF__APPdfContext__) */
