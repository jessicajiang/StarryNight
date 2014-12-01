//
//  SusStars.m
//  StarryNight
//
//  Created by Jessica Jiang on 8/15/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "SusStars.h"
#import "StarStarry.h"
#import "RatchetSparkles.h"
#import "Replay.h"

@implementation SusStars {
    int lives;
    CCSprite *_heart1;
    CCSprite *_heart2;
    CCSprite *_heart3;
    CCLabelTTF *_scoreLabel;
    RatchetSparkles *_explain;
    CGSize scene;
    int count;
}

-(void) onEnter
{
    [super onEnter];
    lives = 3;
    
    scene = [self boundingBox].size;
    
    //initializes explanation
    _explain = [[RatchetSparkles alloc]initWithString:[NSString stringWithFormat:@"Don't break the constellation!"] fontName:@"GillSans" fontSize:20];
    _explain.position = ccp(0.5*scene.width, 0.5*scene.height);
    _explain.visible = true;
    _explain.opacity = 1;
    [self addChild:_explain];
    
    
    //initializes the score label
    _scoreLabel = [[CCLabelTTF alloc]initWithString:[NSString stringWithFormat:@"Score:"] fontName:@"GillSans" fontSize:20];
    _scoreLabel.position = ccp(0.5*scene.width, 0.90*scene.height);
    _scoreLabel.visible = true;
    _scoreLabel.opacity = 1;
    [self addChild:_scoreLabel];
    
}

-(BOOL)winCondition{
    return lives <= 0;
}

-(void)loseLife {
    if (lives ==3) {
        _heart1.visible = false;
    } else if (lives ==2) {
        _heart2.visible = false;
    } else if (lives ==1) {
        _heart3.visible = false;
    }
    lives--;
}

-(void) endAttempt:(BOOL) completed
{
    if ( !completed )
        [self loseLife];
    [super endAttempt:completed];
    
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

-(void)mainmenu {
    CCScene *mainmenuScene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:mainmenuScene];
}

- (void)showScore
{
    
    _scoreLabel.string = [NSString stringWithFormat:@"Score: %d", [self score]];
    _scoreLabel.visible = true;
}

-(void)endGame
{
    [super endGame];
    [Replay level:2];
}

-(void) update:(CCTime)delta {
    if (count <60) {
        count += 1;
    }
    else if (count == 60){
        [self randomlyGenerateStars:30];
        count += 1;
    }
    else
    {
        [super update:delta];
    }
    
    [self showScore];
    
}

@end
