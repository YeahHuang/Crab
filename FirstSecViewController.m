#import "FirstSecViewController.h"

NSString *gtxt;

@interface FirstSecViewController ()

@end

@implementation FirstSecViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)click1:(id)sender {
    gtxt = @"wnm";
}

- (IBAction)click2:(id)sender {
    gtxt = @"hhh";
}

- (IBAction)click3:(id)sender {
    gtxt = @"NoZuoNoDie";
}

- (IBAction)click4:(id)sender {
    gtxt = @"xianrou";
}

- (IBAction)click5:(id)sender {
    gtxt = @"manfen";
}

@end
