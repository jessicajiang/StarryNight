//
//  Win.m
//  StarryNight
//
//  Created by Jessica Jiang on 7/31/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Win.h"


@implementation Win {
    CCLabelTTF *_bestTime;
}


- (void)replay {
    CCScene *gameplayScene = [CCBReader loadAsScene:@"Gameplay"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
}

- (void)mainmenu {
    CCScene *mainmenuScene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:mainmenuScene];
}

-(void) onEnter {
    [super onEnter];
    
    _bestTime.string = [NSString stringWithFormat:@"%d", time];
    [self updateBestTime:time];
    
    _bestTime.string = [NSString stringWithFormat:@"%d", [self bestTime]];
}

+ (void) checkTime:(int) i {
    //time = t;
}

-(int)bestTime
{
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"YayTime"]!=nil)
    {
        return [[NSUserDefaults standardUserDefaults] integerForKey:@"YayTime"];
    }
    else
    {
        return 0;
    }
}

-(void)updateBestTime:(int) i
{
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"YayTime"]==nil)
    {
        [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"YayTime"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    
    if(time >[[NSUserDefaults standardUserDefaults] integerForKey:@"YayTime"])
    {
        [[NSUserDefaults standardUserDefaults] setInteger:time forKey:@"YayTime"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
@end
