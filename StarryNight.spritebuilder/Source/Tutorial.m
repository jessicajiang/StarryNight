//
//  Tutorial.m
//  StarryNight
//
//  Created by Jessica Jiang on 7/28/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

//basically this is what's going to go down in tutorial:
//start off with a screen that says "welcome" or something
//allow one star to appear on screen
//add another of the same color
//the words "to connect, press and drag."
//"connect stars of the same color"
//"do not touch stars of opposite color"
//"the longer the chain, the more points you earn"


#import "Tutorial.h"
#import "RatchetSparkles.h"

@implementation Tutorial {
    RatchetSparkles *_welcome;
    RatchetSparkles *connectTheStars;
    RatchetSparkles *warning;
    RatchetSparkles *scores;
    RatchetSparkles *complete;
    
    BOOL firstStage;
    BOOL secondStage;
    BOOL thirdStage;
    BOOL gameOver;
    
    float time;
    int count;
    int score;
    
    CCLabelTTF *_scoreLabel;
}


-(void) onEnter {
    self.numStars = 2;
    [super onEnter];
    
    [self endGame];
    
    count = 0;
    score = 0;


    //initializes the welcome screen
    _welcome = [[RatchetSparkles alloc]initWithString:@"Welcome" fontName:@"GillSans" fontSize:40];
    //_welcome.position = ccp(0.5*scene.width, 0.5*scene.height);
    _welcome.position = ccp(0.5*self.contentSize.width, 0.5*self.contentSize.height);
    _welcome.visible = true;
    _welcome.opacity = 1;
    [self addChild:_welcome];
    [_welcome setLife: 200];
    
    //generate two yellow stars in gameplay
    gameOver = false;
    firstStage = false;
    secondStage = false;
    thirdStage = false;
    
    [self loadLevel1];
}

-(void) loadLevel1
{
    firstStage = false;
    
    connectTheStars = [[RatchetSparkles alloc]initWithString:@"Connect the Stars"];
    connectTheStars.position = ccp(0.5*self.contentSize.width, 0.4*self.contentSize.height);
    connectTheStars.visible = true;
    connectTheStars.opacity = 1;
    [self addChild:connectTheStars];
    [connectTheStars setLife: 100];
    
    StarStarry *star1 = [self generateStarAt:ccp( 1.0/3 * self.contentSize.width, 0.3 * self.contentSize.height) withColor:([CCColor yellowColor])];
    StarStarry *star2 = [self generateStarAt:ccp( 2.0/3 * self.contentSize.width, 0.3 * self.contentSize.height) withColor:([CCColor yellowColor])];
    
    [star1 stopStar];
    [star2 stopStar];
}

-(void) loadLevel2
{
    secondStage = false;
    
    warning = [[RatchetSparkles alloc]initWithString:@"Avoid Other Colors!"];
    warning.position = ccp(0.5*self.contentSize.width, 0.4*self.contentSize.height);
    warning.visible = true;
    warning.opacity = 1;
    [self addChild:warning];
    [warning setLife: 50];
    
    [self generateRandStar:([CCColor yellowColor])];
    [self generateRandStar:([CCColor yellowColor])];
    [self generateRandStar:([CCColor greenColor])];
    [self generateRandStar:([CCColor greenColor])];
}

-(void) loadLevel3
{
    thirdStage = false;
    
    scores = [[RatchetSparkles alloc]initWithString:@"More Stars - More Points!"];
    scores.position = ccp(0.5*self.contentSize.width, 0.4*self.contentSize.height);
    scores.visible = true;
    scores.opacity = 1;
    [self addChild:scores];
    [warning setLife: 100];
    
    [self generateRandStar:([CCColor yellowColor])];
    [self generateRandStar:([CCColor yellowColor])];
    [self generateRandStar:([CCColor yellowColor])];
    [self generateRandStar:([CCColor yellowColor])];
    [self generateRandStar:([CCColor yellowColor])];
    [self generateRandStar:([CCColor yellowColor])];
}


-(void) starsAtTouchEnd:(StarStarry *)star withCompletion:(BOOL)completed
{
    if(completed)
        [self removeStar:star];
}

-(BOOL) winCondition
{
    // to be decided by game mode.
    return gameOver;
}

-(void) winGame
{
    
    [self endGame];
    
    
    CCScene *MainScene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:MainScene];
}

-(void) update:(CCTime)delta
{
    time += delta;
    count += 1;
    
    if ( !firstStage && self.numStars == 0 )
    {
        firstStage = true;
        [self loadLevel2];
    }
    
    if ( !secondStage && firstStage && self.numStars == 0)
    {
        secondStage = true;
        [self loadLevel3];
    }
    
    if ( !thirdStage && secondStage && self.numStars == 0 )
    {
        thirdStage = true;
        
        complete = [[RatchetSparkles alloc]initWithString:@"Good Job!" fontName:@"GillSans" fontSize:30];
        complete.position = ccp(0.5*self.contentSize.width, 0.5*self.contentSize.height);
        complete.visible = true;
        complete.opacity = 1;
        [self addChild:complete];
        
        count = 0;
    }
    
    if ( thirdStage && count >= 50 )
        gameOver = true;
    
    [super update:delta];
    
    
}

@end
