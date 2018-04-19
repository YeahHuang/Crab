//
//  Lesson.m
//  Vocavularist
//
//  Created by Devine Lu Linvega on 2015-05-10.
//  Copyright (c) 2015 XXIIVV. All rights reserved.
//

#import "Lesson.h"
#import "xxiivvViewController.h"
#import <CoreData/CoreData.h>

NSArray * currentLesson;

@implementation Lesson

-(Lesson*)initWithLessonMode :(lessonMode)lessonMode
{
	if( lessonMode == NAME ){ currentLesson = [self NAMELesson]; }
    else if (lessonMode == HAHA) { currentLesson = [self HAHALesson]; }
	else{ currentLesson = [self FESTIVALLesson]; }
	
	return self;
}

-(NSString*)question:(int)lessonId
{
    int targetField = 1;
	return currentLesson[lessonId][targetField];
}

-(NSUInteger)length
{
	return [currentLesson count];
}

-(NSArray*)mistakesFromLessonId:(int)lessonId :(lessonMode)lessonMode
{
	// Make potential answers
	NSRange targetRange = NSMakeRange(0, lessonId+4);
	if(lessonId > 200){ targetRange = NSMakeRange(0, lessonId+1); }
	NSMutableArray * newArray = [NSMutableArray arrayWithArray:[currentLesson subarrayWithRange:targetRange]];
	
	[newArray removeObjectAtIndex:lessonId];
	
	newArray = [self shuffleArray:newArray];
	
	int targetField = (int)[newArray[0] count] -1;
	
	if( lessonMode == NAME ){ targetField = 2; }
    targetField = 0;
	
	return @[newArray[0][targetField],newArray[1][targetField],newArray[2][targetField]];
}

-(NSString*)answerFromLessonId:(int)lessonId :(lessonMode)lessonMode
{
	int targetField = (int)[currentLesson[lessonId] count] -1;
	
	if( lessonMode == NAME ){ targetField = 2; }
     targetField = 0;
	return currentLesson[lessonId][targetField];
}

- (NSMutableArray*)shuffleArray:(NSMutableArray*)targetArray
{
	NSUInteger count = [targetArray count];
	for (NSUInteger i = 0; i < count; ++i) {
		NSInteger remainingCount = count - i;
		NSInteger exchangeIndex = i + arc4random_uniform((u_int32_t )remainingCount);
		[targetArray exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
	}
	
	return targetArray;
}


-(NSArray*)FESTIVALLesson
{
	NSLog(@"! LESSON | Loading FESTIVAL");
	
	return @[
             @[@"爱", @"love"],
             @[@"我",@"I",@"一手食指指自己"],
             @[@"你",@"you",@"一手食指指向对方"],
             @[@"男",@"male",@"一手直立，五指并拢在头侧自后向前挥动，以“短发”表示男子。"],
             @[@"女",@"female",@"一手拇、食指捏耳垂，象征耳环，泛指妇女"],
             @[@"爸爸",@"father",@"一手伸拇指贴在嘴唇上。"],
             @[@"哈哈哈",@"hhh"]
	];
}

-(NSArray*)NAMELesson
{
	NSLog(@"! LESSON | Loading NAME");
	
	return @[
             @[@"你们",@"yous",@"一手食指先指对方，然后掌心向下，在胸前平行转一圈"],
             @[@"我",@"I",@"一手食指指自己"],
             @[@"你",@"you",@"一手食指指向对方"],
             @[@"男",@"male",@"一手直立，五指并拢在头侧自后向前挥动，以“短发”表示男子。"],
             @[@"女",@"female",@"一手拇、食指捏耳垂，象征耳环，泛指妇女"],
             @[@"爸爸",@"father",@"一手伸拇指贴在嘴唇上。"],
             @[@"妈妈",@"mother",@"一手伸食指贴在嘴唇上"],
             @[@"我",@"I",@"一手食指指自己"],
             @[@"你",@"you",@"一手食指指向对方"],
             @[@"男",@"male",@"一手直立，五指并拢在头侧自后向前挥动，以“短发”表示男子。"],
             @[@"女",@"female",@"一手拇、食指捏耳垂，象征耳环，泛指妇女"]

	 ];
}

-(NSArray*)HAHALesson
{
    NSLog(@"! LESSON | Loading HAHA");

    return @[
             @[@"哈哈哈",@"hhh"],
             @[@"No Zuo No Die",@"NoZuoNoDie"],
             @[@"这B我给满分",@"manfen"],
             @[@"小鲜肉们快到碗里来",@"xianrou"],
             @[@"大家好我叫王尼玛",@"wnm"],
             @[@"哈哈哈",@"hhh"],
             @[@"No Zuo No Die",@"NoZuoNoDie"],
             @[@"这B我给满分",@"manfen"]
    ];
}

@end
