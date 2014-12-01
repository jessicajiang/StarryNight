//
//  RatchetSparkles.h
//  StarryNight
//
//  Created by Jessica Jiang on 8/13/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCLabelTTF.h"

@interface RatchetSparkles : CCLabelTTF

-(id) initWithString:(NSString *) string;
-(id) initWithInt:(int) number;
-(id) initWithString:(NSString *)string fontName:(NSString *)name fontSize:(CGFloat)size;

-(void) setLife: (int) newLife;


@end
