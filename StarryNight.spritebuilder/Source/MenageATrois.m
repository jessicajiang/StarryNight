//
//  HeapOStars.m
//  StarryNight
//
//  Created by Jessica Jiang on 7/24/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//
#import "MenageATrois.h"
#import "RatchetSparkles.h"
#import "Replay.h"

//static int level;
@implementation MenageATrois {
    CGSize scene;
    
    CCLabelTTF *_numberStars;
    CCLabelTTF *_timer;
    CCLabelTTF *_scoreLabel;
    RatchetSparkles *_explain;
    int strokes;
    int numStars;
    float spawnPeriod;
    float count;
    float time;
    
}

//TODO: WHY DOESNT THE NUMBER OF STARS LABEL UPDATE D:

//TODO: IF YOU GET RID OF THE _TIMER AND _SCORELABEL HERE, THE GAMEPLAYBASE LABELS WILL APPEAR; IF THEY ARE HERE, THEN THE SPRITEBUILDER LABELS WILL APPEAR

#pragma mark - onEnter
-(void)onEnter {
    [super onEnter];
    
    self.type = @"MenageATrois";
    //level = 2;
    scene = [self boundingBox].size;
    
    spawnPeriod = 60;
    count = 0;
    time = 120;
    //self.numStars = 30;
    
    //initializes explanation
    _explain = [[RatchetSparkles alloc]initWithString:[NSString stringWithFormat:@"Game Over at 75 Stars"] fontName:@"GillSans" fontSize:20];
    _explain.position = ccp(0.5*scene.width, 0.6*scene.height);
    _explain.visible = true;
    _explain.opacity = 1;
    [self addChild:_explain];
    
    //initializes number of stars label
    _numberStars = [[CCLabelTTF alloc]initWithString:[NSString stringWithFormat:@"Stars: %d", 0] fontName:@"GillSans" fontSize:20];
    _numberStars.position = ccp(0.85*scene.width, 0.85*scene.height);
    _numberStars.visible = true;
    _numberStars.opacity = 1;
    [self addChild:_numberStars];
    
    //initializes the score label
    _scoreLabel = [[CCLabelTTF alloc]initWithString:[NSString stringWithFormat:@"Score:"] fontName:@"GillSans" fontSize:20];
    _scoreLabel.position = ccp(0.5*scene.width, 0.85*scene.height);
    _scoreLabel.visible = true;
    _scoreLabel.opacity = 1;
    [self addChild:_scoreLabel];
    
    NSLog(@"height: %f width: %f", self.contentSizeInPoints.height, self.contentSizeInPoints.width);
    
}


-(void)randomlyGenerateStars:(int) num{
    for(int i = 0; i < num; i++){
        if(i % 3 == 0){
            [self generateRandStar:[CCColor greenColor]];
        } else if (i %3 == 1) {
            [self generateRandStar:[CCColor yellowColor]];
        } else {
            [self generateRandStar:[CCColor orangeColor]];
        }
        
    }
    self.numStars = num;
}

/*
#pragma mark - showStrokeCount
- (void)showStrokeCount
{
    _numberStars.string = [NSString stringWithFormat:@"Stars: %d", [self numStars]];
    _numberStars.visible = true;
}
*/

- (void)showScore {
    _scoreLabel.string = [NSString stringWithFormat:@"Score: %d", [self score]];
    _scoreLabel.visible = true;
}

#pragma mark - showTimeLeft

- (void)showTimeLeft
{
    int timeInt = (int) time;
    _timer.string = [NSString stringWithFormat:@"Time: %d", timeInt];
    _timer.visible = true;
}

-(void) starsAtTouchEnd:(StarStarry *)star withCompletion:(BOOL)completed
{
    if(completed)
        [self removeStar:star];
    else
        [super starsAtTouchEnd:star withCompletion:completed];
}

-(BOOL)winCondition
{
    return self.numStars >= 75;
    CCScene *youSuck = [CCBReader loadAsScene:@"Replay"];
    [[CCDirector sharedDirector] replaceScene:youSuck];
}

-(void)mainmenu {
    CCScene *mainmenuScene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:mainmenuScene];
}


#pragma mark - spawnStar
-(void) spawnStar
{
    int rand = arc4random() % 3;
    
    if ( rand == 0 )
        [self generateRandStar:[CCColor greenColor]];
    else if (rand == 1)
        [self generateRandStar:[CCColor yellowColor]];
    else
        [self generateRandStar:[CCColor orangeColor]];
    //count = 0;
    
}

-(void) showStarNum {
    _numberStars.string = [NSString stringWithFormat:@"Stars: %d", self.numStars];
    _numberStars.visible = true;
}


#pragma mark - update
// do all the collision checking
- (void)update:(CCTime)delta
{
    //[self showStrokeCount];
    [self showScore];
    [self showTimeLeft];
    [self showStarNum];
    
    //time -= delta;
    
    if (count <60) {
        count += 1;
    }
    else if (count == 60){
        [self randomlyGenerateStars:30];
        count += 1;
    }
    else
    {
        time -= delta;
        [super update:delta];
    }
    
}

-(void)endGame
{
    
    [super endGame];
    [Replay level:3];
}

/*
-(int)bestTime
{
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"Time"]==nil)
    {
        return [[NSUserDefaults standardUserDefaults] integerForKey:@"Time"];
    }
    else
    {
        return 0;
    }
}
 */

-(void)updateHighScores:(int)i
{
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"Time"]==nil)
    {
        [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"Time"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    
    if((int)time>[[NSUserDefaults standardUserDefaults] integerForKey:@"Time"])
    {
        [[NSUserDefaults standardUserDefaults] setInteger:(int)time forKey:@"Time"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

@end
