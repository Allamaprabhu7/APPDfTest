//
//  APPdfViewController.m
//  iPhonePDF
//
//  Created by allamaprabhu on 5/25/14.
//
//

#import "APPdfViewController.h"
#import "APPdfContext.h"
#import "APPdfView.h"
#import "APPdfLabel.h"
#import "APPDFImageView.h"

@interface APPdfViewController ()

@end

@implementation APPdfViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)loadView {
    self.view =  [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view.backgroundColor = [UIColor orangeColor];
    
//     NSError *error = nil;
    
     NSArray *arrayPaths =
     NSSearchPathForDirectoriesInDomains(
     NSDocumentDirectory,
     NSUserDomainMask,
     YES);
     NSString *path = [arrayPaths objectAtIndex:0];
    NSLog(@"PATH : %@",path);
     path = [path stringByAppendingPathComponent:@"test.pdf"];
    
    
    char *cpath = (char *)[path cStringUsingEncoding:NSUTF8StringEncoding];
    AP_InitPdfContext(cpath);
    AP_AddPage();
    
    APPdfView *view = [[APPdfView alloc] init];
    view.frame = CGRectMake(100, 600, 400, 400);
    [view setNeedsDisplay];
    
    NSString *imagepath  =  @"/Users/asotti/Downloads/1.jpg";
    
    APPDFImageView *imageView = [[APPDFImageView alloc] initWithImage:imagepath];
    imageView.frame = CGRectMake(200, 200, 100, 100);
    [view addSubView:imageView];
    
    APPdfView *view1 = [[APPdfView alloc] init];
    view1.frame = CGRectMake(100, 100, 200, 200);
    

    APPdfView *view2 = [[APPdfView alloc] init];
    view2.frame = CGRectMake(20, 20, 50, 50);
    
    APPdfView *view3 = [[APPdfView alloc] init];
    view3.strokeColor = [UIColor greenColor];
    view3.frame = CGRectMake(20, 130, 50, 50);
    [view addSubView:view3];
    

    APPdfLabel *label = [[APPdfLabel alloc] init];
    label.alignment = APTextAlignmentCentre;
    label.font = [UIFont fontWithName:@"Helvetica" size:30];
    label.frame = CGRectMake(20, 20, 250, 100);
    label.text = @"Hello World";
    label.lineWidth = 5.0;
    label.strokeColor = [UIColor redColor];
    
    [view addSubView:label];
    
    AP_savePdfAndCleanUp(cpath, AP_getCurrentPdfDoc());
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(0, 100, 100, 50);
    [button setTitle:@"share" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    [self.navigationController setNavigationBarHidden:NO];
    
    UIBarButtonItem *shareItem = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"shareButton.png"] style:UIBarButtonItemStylePlain target:self action:@selector(ShareButtonAction:)] autorelease];
  
    self.navigationItem.rightBarButtonItem = shareItem;
}

- (void)ShareButtonAction:(id)sender {
    NSLog(@"%s",__PRETTY_FUNCTION__);
    
    NSArray *arrayPaths =
    NSSearchPathForDirectoriesInDomains(
                                        NSDocumentDirectory,
                                        NSUserDomainMask,
                                        YES);
    NSString *path = [arrayPaths objectAtIndex:0];
    path = [path stringByAppendingPathComponent:@"test.pdf"];
    NSData *attachementData = [NSData dataWithContentsOfFile:path];

    
    
    MFMailComposeViewController *mf = [[[MFMailComposeViewController alloc] init] autorelease];
    mf.mailComposeDelegate = self;
    [mf setSubject:@"Attaching Pdf Template"];
    
    [mf addAttachmentData:attachementData mimeType:@"application/pdf" fileName:@"Template.pdf"];
    [self presentViewController:mf animated:YES completion:^(){
        NSLog(@"%s",__PRETTY_FUNCTION__);
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadPDFFile];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)loadPDFFile
{
    NSArray *arrayPaths =
    NSSearchPathForDirectoriesInDomains(
                                        NSDocumentDirectory,
                                        NSUserDomainMask,
                                        YES);
    NSString *path = [arrayPaths objectAtIndex:0];
    path = [path stringByAppendingPathComponent:@"test.pdf"];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    CGRect r = self.view.bounds;
    r.origin.y = r.origin.y + 47;
    UIWebView *webView = [[UIWebView alloc] initWithFrame:r];
    [webView loadRequest:request];
    [self.view addSubview:webView];
//    [self.view sendSubviewToBack:webView];
}


#pragma -mark Mail composition view delegate
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    if (result == MFMailComposeResultCancelled | result == MFMailComposeResultSaved | result ==  MFMailComposeResultFailed | result == MFMailComposeResultSent) {
        [self dismissViewControllerAnimated:YES completion:^(void){
        }];
    }
}

@end
