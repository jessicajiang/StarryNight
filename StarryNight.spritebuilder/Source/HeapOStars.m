//
//  HeapOStars.m
//  StarryNight
//
//  Created by Jessica Jiang on 7/24/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "HeapOStars.h"
#import "StarStarry.h"
#import "RatchetSparkles.h"

//static int level;

@implementation HeapOStars {
    CGSize scene;

    //CCLabelTTF *_numberStars;
    CCLabelTTF *_timer;
    int strokes;
    float spawnPeriod;
    float count;
    float time;
    RatchetSparkles *_explain;
    float perMult;
}


#pragma mark - onEnter

-(void)onEnter {
    [super onEnter];
    
    self.type = @"HeapOfStars";
    //level = 1;
    scene = [self boundingBox].size;
    //MASA WAS HERE TOO <3
    spawnPeriod = 90;
    count = 0;
    time = 60;
    perMult = 1;
    
    //[self randomlyGenerateStars:30];
    
    //initializes the stroke count
    /*
    _numberStars = [[CCLabelTTF alloc]initWithString:[NSString stringWithFormat:@"Moves: %d", [self numStars]] fontName:@"Helvetica" fontSize:30];
    _numberStars.position = ccp(0.2*self.contentSizeInPoints.width, 0.2*self.contentSizeInPoints.height);
    _numberStars.visible = true;
    _numberStars.opacity = 0.45;
    [self addChild:_numberStars];
     */
    
    
    
}

#pragma mark - showStrokeCount
- (void)showStrokeCount
{
    //_numberStars.string = [NSString stringWithFormat:@"Stars: %d", [self numStars]];
    //_numberStars.visible = true;
}

#pragma mark - showTimeLeft

- (void)showTimeLeft
{
    int timeInt = (int) time;
    _timer.string = [NSString stringWithFormat:@"Time: %d", timeInt];
    _timer.visible = true;
}

#pragma mark - loseCondition

//-(BOOL) loseCondition
//{
//     return self.numStars >= 60;
//    //TODO: perhaps implement a warning method when the number of stars reaches close to 45
//}

#pragma mark - winCondition

//-(BOOL)winCondition
//{
//    return self.numStars >= 60;
//    
//}

-(void) starsAtTouchEnd:(StarStarry *)star withCompletion:(BOOL)completed
{
    if(completed)
        [self removeStar:star];
    else
        [super starsAtTouchEnd:star withCompletion:completed];
}

#pragma mark - spawnStar
-(void) spawnStar
{
    int rand = arc4random() % 2;
        
    if ( rand == 0 )
        [self generateRandStar:[CCColor greenColor]];
    else
        [self generateRandStar:[CCColor yellowColor]];


}

#pragma mark - update
// do all the collision checking
- (void)update:(CCTime)delta
{
    [super update:delta];
    //[self showStrokeCount];
    [self showTimeLeft];
    
    spawnPeriod = 3 * self.numStars / perMult;
    
    time -= delta;
    
    if ( count >= spawnPeriod )
    {
        [self spawnStar];
        count -= spawnPeriod;
    
    }
    count+=1;
}

-(void) endAttempt:(BOOL) completed
{
    if ( !completed )
        perMult *= 1.5;
    [super endAttempt:completed];
    
}



@end
