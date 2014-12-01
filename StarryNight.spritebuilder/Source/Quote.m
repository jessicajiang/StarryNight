//
//  Quote.m
//  StarryNight
//
//  Created by Jessica Jiang on 8/15/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Quote.h"

@implementation Quote


-(void)onEnter {
    [super onEnter];
    self.userInteractionEnabled = TRUE;
    
    CCNode* temp = [CCBReader load:@"BackGroundStar"];
    [self addChild:temp];
    [self twinkle:temp];
}

-(void) button {
    CCScene *tutorialScene = [CCBReader loadAsScene:@"Tutorial"]; //Gameplay is supposed to be GameplayStarry
    [[CCDirector sharedDirector] replaceScene:tutorialScene];
}

-(void)twinkle:(CCNode*) mahStar
{
    if ( self.parent.contentSize.width == 0 || self.parent.contentSize.height == 0)
    {
        return;
    }
    int randomX = arc4random()%((int)self.parent.contentSize.width);
    int randomY = arc4random()%((int)self.parent.contentSize.height);
    mahStar.position = ccp(randomX,randomY);
    
    [self fadeIn:mahStar];
}

-(void)fadeIn:(CCNode*) mahStar
{
    if(mahStar.opacity<=1)
    {
        mahStar.opacity+=.1;
        
        [self performSelector:@selector(fadeIn:) withObject:mahStar afterDelay:0.1f];
    }
    else
    {
        
        [self fadeOut:mahStar];
    }
}

-(void)fadeOut:(CCNode*) mahStar
{
    if(mahStar.opacity>=0)
    {
        
        mahStar.opacity-=.1;
        [self performSelector:@selector(fadeOut:) withObject:mahStar afterDelay:0.1f];
    }
    else
    {
        
        [self twinkle:mahStar];
    }
}


@end
