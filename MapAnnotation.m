//
//  MapAnnotation.m
//  SaveEat
//
//  Created by Ankur Patel on 12/9/14.
//  Copyright (c) 2014 Ankur Patel. All rights reserved.
//

#import "MapAnnotation.h"

@implementation MapAnnotation

@synthesize title,subtitle;


- (void)dealloc {
    [title release];
    [subtitle release];
    [super dealloc];
}
@end
