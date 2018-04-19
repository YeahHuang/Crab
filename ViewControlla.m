#import "ViewControlla.h"
#import "RPRingedPages.h"

@interface ViewControlla () <RPRingedPagesDelegate, RPRingedPagesDataSource>
@property (weak, nonatomic) IBOutlet UIButton *btn;

@property (strong, nonatomic) IBOutlet UIView *tabbarItem;
@property (nonatomic, strong) RPRingedPages *pages;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation ViewControlla
- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

- (RPRingedPages *)pages {
    if (_pages == nil) {
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
        CGRect pagesFrame = CGRectMake(0, screenHeight*0.6, screenWidth, screenWidth * 0.4);
        
        RPRingedPages *pages = [[RPRingedPages alloc] initWithFrame:pagesFrame];
        CGFloat height = pagesFrame.size.height - pages.pageControlHeight - pages.pageControlMarginTop - pages.pageControlMarginBottom;
        pages.carousel.mainPageSize = CGSizeMake(screenWidth*0.35, screenWidth*0.35);
        pages.carousel.pageScale = 0.6;
        pages.dataSource = self;
        pages.delegate = self;
        
        _pages = pages;
    }
    return _pages;
}
- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
        _dataSource[0] = @"节日";
        _dataSource[1] = @"称谓";
        _dataSource[2] = @"哈哈";
        _dataSource[3] = @"礼貌";
        _dataSource[4] = @"志愿";
        _dataSource[5] = @"祝福";
        _dataSource[6] = @"字母";
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.pages];
    [self.view bringSubviewToFront:_btn];
    [self makeDataSource];
    [self.pages reloadData];
    
}

- (void)makeDataSource {
//    for (int i=0; i<7; i++) {
//        NSString *s = [NSString stringWithFormat:@"%c", i + 'A'];
//        [self.dataSource addObject:s];
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfItemsInRingedPages:(RPRingedPages *)pages {
    return self.dataSource.count;
}
- (UIView *)ringedPages:(RPRingedPages *)pages viewForItemAtIndex:(NSInteger)index {
    UILabel *label = (UILabel *)[pages dequeueReusablePage];
    if (![label isKindOfClass:[UILabel class]]) {
        label = [UILabel new];
        label.font = [UIFont systemFontOfSize:25];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.layer.backgroundColor = [UIColor blackColor].CGColor;
        label.layer.cornerRadius = 5;
    }
    label.text = self.dataSource[index];
    return label;
}
- (void)didSelectedCurrentPageInPages:(RPRingedPages *)pages {
    
    NSLog(@"pages selected, the current index is %zd", pages.currentIndex);
}
- (void)pages:(RPRingedPages *)pages didScrollToIndex:(NSInteger)index {
    NSLog(@"pages scrolled to index: %zd", index);
}

- (IBAction)changeMainPageSize:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 1:
            self.pages.carousel.mainPageSize = CGSizeMake(60, 100);
            break;
        case 2:
            self.pages.carousel.mainPageSize = CGSizeMake(100, 100);
            break;
        default: {
            self.pages.carousel.mainPageSize = self.originMainPageSize;
            break;
        }
    }
    self.pages.carousel.mainPageSize = CGSizeMake(100, 100);
    [self.pages reloadData];
}

//- (IBAction)changePageScale:(UISegmentedControl *)sender {
   /* switch (sender.selectedSegmentIndex) {
        case 1:
            self.pages.carousel.pageScale = 0.8;
            break;
        case 2:
            self.pages.carousel.pageScale = 0.5;
            break;
        default:
            self.pages.carousel.pageScale = 0.6;
            break;
    }*/
//    self.pages.carousel.pageScale = 0.6;
//    [self.pages reloadData];
//}

- (CGSize)originMainPageSize {
    CGFloat height = [UIScreen mainScreen].bounds.size.width * 0.4;
    height -= (self.pages.pageControlHeight + self.pages.pageControlMarginTop + self.pages.pageControlMarginBottom);
    return CGSizeMake(height * 0.8, height);
}

@end
