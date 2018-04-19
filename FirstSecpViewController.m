#import "FirstSecpViewController.h"
#import "GifView.h"

extern NSString *gtxt;

@interface FirstSecpViewController ()

@end

@implementation FirstSecpViewController

- (void)viewDidLoad {
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    [super viewDidLoad];
     //Do any additional setup after loading the view.
     NSString *path =[@"Picture/" stringByAppendingString:gtxt];
    NSData *localData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:path ofType:@"gif"]];
    GifView *dataView = [[GifView alloc] initWithFrame:CGRectMake(45,120,285,400) data:localData];
    [self.view addSubview:dataView];
    //[dataView release];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
