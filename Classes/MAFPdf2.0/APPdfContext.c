//
//  APPdfContext.c
//  iPhonePDF
//
//  Created by allamaprabhu on 12/2/14.
//
//

#include "APPdfContext.h"
static AP_PDFService_userData userdata;
extern void PDFService_defaultErrorHandler1(HPDF_STATUS   error_no,
                                     HPDF_STATUS   detail_no,
                                     void         *user_data)
{
    //    PDFService_userData1 *userData = (PDFService_userData1 *)user_data;
    //    HPDF_Doc pdf = userData->pdf;
    //    //    PDFService *service = userData->service;
    //    NSString *filePath = userData->filePath;
    //    filePath = NULL;
    //
    //    //  HPDF_ResetError(pdf)
    //    HPDF_Free(pdf);
    
    //    if (service.delegate) {
    //        [service.delegate service:service
    //         didFailedCreatingPDFFile:filePath
    //                          errorNo:error_no
    //                         detailNo:detail_no];
    //    }
}

extern HPDF_Doc AP_getCurrentPdfDoc(void)
{
    static HPDF_Doc pdf = NULL;
    if (NULL == pdf) {
        pdf = HPDF_New(PDFService_defaultErrorHandler1, &userdata);
        userdata.pdf = pdf;
    }
    return pdf;
}

extern void AP_InitPdfContext(char *path)
{
    userdata.filePath = path;
}

extern void AP_AddPage()
{
    HPDF_Page page = HPDF_AddPage(AP_getCurrentPdfDoc());
    HPDF_Page_SetSize(page, HPDF_PAGE_SIZE_A4, HPDF_PAGE_LANDSCAPE);
    //TODO change this-1000
    HPDF_Page_SetHeight(page, 1000);
}

extern void AP_savePdfAndCleanUp(char *path,HPDF_Doc pdf)
{
    HPDF_SaveToFile(pdf, path);
    printf("[libharu] Freeing PDF object ");
    if (HPDF_HasDoc(pdf)) {
        HPDF_Free(pdf);
    }
    printf("[libharu] PDF Creation END");
}