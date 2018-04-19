//
//  SecondViewController.m
//  CrabSignLanguage
//
//  Created by 黄霄 on 06/03/2018.
//  Copyright © 2018 crab. All rights reserved.
//

#import "SecondViewController.h"
#import "string.h"
#import "GifView.h"
#import "FirstSecpViewController.h"
extern NSString *gtxt;
NSMutableArray *words;
NSMutableArray *chinese;
NSMutableArray *explanation;
NSMutableArray *imageID;
@interface SecondViewController ()
@property (weak, nonatomic) IBOutlet UITextField *searchText;
@property (weak, nonatomic) IBOutlet UIImageView *Image;
@property (weak, nonatomic) IBOutlet UILabel *word;
@property (weak, nonatomic) IBOutlet UILabel *furtherExplanation;

@end

@implementation SecondViewController
- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}
- (IBAction)editingEnded:(id)sender {
   [_searchText endEditing:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

-(void) showWords:(NSString*) txt{
    if (!words) [self initializeWords];
    /*NSMutableArray *words = [NSMutableArray arrayWithObjects:@"love",@"you",@"xianrou",@"I",@"mb",nil];
     NSMutableArray *chinese = [NSMutableArray arrayWithObjects:@"爱",@"你们",@"小鲜肉们快到碗里来",@"我",@"",nil];
     NSMutableArray *explanation = [ NSMutableArray arrayWithObjects:@"右手轻轻抚摩左手拇指指背",@"一手食指先指对方，然后掌心向下，在胸前平行转一圈",@"😄",@"一手食指指自己",@"抱歉，目前还木有这个词",nil];*/
    //NSMutableArray *collect;
    NSInteger flag = 0;
    NSInteger i;
    NSInteger debug = 1;
    for (i=0;i<[words count];i++)
    {
        //  [ collect addObject:@(1) ] ;
    }  //initialize the collect function
    if (debug) NSLog(@"Search Button clicked");
    if (debug) NSLog(@"txt = %@",txt);
    self.word.backgroundColor = [UIColor blackColor];
    self.furtherExplanation.backgroundColor = [UIColor blackColor];
    flag = 0;
    for (i=0;i<[words count]-1;i++)
    {
        NSString *txt1 = [words objectAtIndex:i];
        NSString *txt2 = [chinese objectAtIndex:i];
        if (debug) NSLog(@"In %ld, txt1 = %@",(long)i,txt1);
        if ( [txt1 containsString:txt] || [txt2 containsString:txt])
        {
            
            NSString *path =[@"Picture/" stringByAppendingString:[imageID objectAtIndex:i]];
            if (debug) NSLog(@"searchedtxt=%@, chinese=%@, english=%@, path=%@",txt, txt2, txt1, path);
            NSData *localData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:path ofType:@"gif"]];
            GifView *dataView = [[GifView alloc] initWithFrame:CGRectMake(120,120,210,260) data:localData];
            [self.view addSubview:dataView];
            //[dataView release];
            self.word.text=[chinese objectAtIndex:i];
            self.furtherExplanation.text=[explanation objectAtIndex:i];
            flag = 1;
            break;
        }
    }
    if (flag==0)
    {
        /*i=[words count]-1;
         txt = [words objectAtIndex:i]; // 此句一开始漏掉了😂
         NSData *localData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:txt ofType:@"gif"]];
         GifView *dataView = [[GifView alloc] initWithFrame:CGRectMake(120,120,210,260) data:localData];
         [self.view addSubview:dataView];
         //[dataView release];
         self.word.text=[chinese objectAtIndex:i];
         self.furtherExplanation.text=[explanation objectAtIndex:i];*/
        NSString *path =@"Picture/mb";
        NSData *localData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:path ofType:@"gif"]];
        GifView *dataView = [[GifView alloc] initWithFrame:CGRectMake(120,120,210,260) data:localData];
        [self.view addSubview:dataView];
        self.word.text = [ NSString stringWithFormat:@""];
        self.furtherExplanation.text = @"抱歉，目前还木有这个词";
    }
    
}

-(void)initializeWords{
    if (!words) words = [[NSMutableArray alloc] init];
    if (!chinese) chinese = [[NSMutableArray alloc] init];
    if (!explanation) explanation = [[NSMutableArray alloc] init];
    if (!imageID) imageID = [[NSMutableArray alloc] init];
    NSString* path = [[NSBundle mainBundle] pathForResource:@"data"
                                                     ofType:@"txt"];
    NSString* content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    NSLog(@"Got contents");
    NSArray* allLinedStrings =
    [content componentsSeparatedByCharactersInSet:
     [NSCharacterSet newlineCharacterSet]];
    NSInteger  n = [allLinedStrings count];
    NSLog(@"n=%ld",n);
    NSInteger i;
    for (i=0;i<n-1;i+=3)
    {
        NSArray* tempStrs =
        [allLinedStrings[i] componentsSeparatedByString: @"-"];
        if ([tempStrs count]==2)
        {
            [chinese addObject:tempStrs[0]];
            [words addObject:tempStrs[1]];
        } else
        {
            [chinese addObject:@""];
            [words addObject:allLinedStrings[i]];
        }
        [explanation addObject: allLinedStrings[i+1]];
        [imageID addObject:allLinedStrings[i+2]];
        
    }
    NSLog(@"%ld %ld %ld %ld",[chinese count], [words count], [explanation count],[imageID count]  );
    NSLog(@"%@ %@",chinese[0],chinese[1]);
    NSLog(@"%@ %@",words[0],words[1]);
    NSLog(@"%@",explanation[0]);
    NSLog(@"%@",imageID[0]);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Read starts");
    [self initializeWords];
    //_searchText.delegate = self;
    // Do any additional setup after loading the view, typically from a nib.
    
    /*
    // then break down even further
    NSString* strsInOneLine =
    [allLinedStrings objectAtIndex:0];
    
    // choose whatever input identity you have decided. in this case ;
    NSArray* singleStrs =
    [currentPointString componentsSeparatedByCharactersInSet:
     [NSCharacterSet characterSetWithCharactersInString:@";"]];
    */
}
- (IBAction)clicked:(id)sender {
    gtxt = @"love";
    [self showWords:gtxt];
}

- (IBAction)clicked2:(id)sender {
    gtxt = @"father";
    [self showWords:gtxt];
}
- (IBAction)clicked3:(id)sender {
    gtxt = @"113";
    [self showWords:@"ayi"];
}

- (IBAction)clicked4:(id)sender {
    //gtxt = @"1384";
    [self showWords:@"bangzhu"];
}

- (IBAction)clicked5:(id)sender {
    //gtxt = @"1597";
    [self showWords:@"bangongshi"];
}

- (IBAction)clicked6:(id)sender {
    // gtxt = @"3035";
    [self showWords:@"caipan"];
}

- (IBAction)clicked7:(id)sender {
   // gtxt = @"4434";
    [self showWords:@"caijian"];
}

- (IBAction)clicked8:(id)sender {
    //gtxt = @"2273";
    [self showWords:@"caichan"];
}

- (IBAction)clicked9:(id)sender {
    //gtxt = @"777";
    [self showWords:@"caise"];
}

- (IBAction)clicked10:(id)sender {
    //gtxt = @"1764";
    [self showWords:@"canjia"];
}


- (IBAction)Search:(id)sender {
    [_searchText endEditing:YES];
   
    NSString *txt = self.searchText.text;
    [self showWords:txt];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    //[_searchText release];
    //[_Image release];
    //[_word release];
    //[_furtherExplanation release];
    //[super dealloc];
}
@end

