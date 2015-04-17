//
//  GameScene.m
//  Mugi
//
//  Created by Jon Como on 4/17/15.
//  Copyright (c) 2015 Jon Como. All rights reserved.
//

#import "GameScene.h"

#import "Mugi.h"

@interface GameScene ()

@property (nonatomic, strong) Mugi *mugi;
@property (nonatomic, strong) SKPhysicsJointPin *dragJoint;

@end

@implementation GameScene

- (instancetype)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        //init
        self.backgroundColor = [UIColor whiteColor];
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:CGRectMake(0.f, 0.f, size.width, size.height)];
        //self.physicsWorld.gravity = CGVectorMake(0.f, 0.f);
        
        _mugi = [[Mugi alloc] initWithScene:self offset:CGPointMake(size.width/2.f, size.height/2.f)];
        [_mugi.head.physicsBody applyAngularImpulse:1.f];
    }
    
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        NSArray *nodes = [self nodesAtPoint:location];
        SKSpriteNode *nodeTouched = nil;
        for (SKNode *node in nodes) {
            if ([node isKindOfClass:[SKSpriteNode class]]) {
                nodeTouched = (SKSpriteNode *)node;
                continue;
            }
        }
        

    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
