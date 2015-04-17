//
//  Mugi.m
//  Mugi
//
//  Created by Jon Como on 4/17/15.
//  Copyright (c) 2015 Jon Como. All rights reserved.
//

#import "Mugi.h"

@interface Mugi ()

@property (nonatomic, weak) SKScene *scene;
@property (nonatomic, copy) UIColor *skinColor;
@property (nonatomic, copy) UIColor *featureColor;

@end

@implementation Mugi

-(instancetype)initWithScene:(SKScene *)scene offset:(CGPoint)offset {
    if (self = [super init]) {
        //init
        _scene = scene;
        _featureColor = [UIColor redColor];
        _skinColor = [UIColor blackColor];
        
        [self constructFaceOffset:offset];
    }
    
    return self;
}

- (void)constructFaceOffset:(CGPoint)offset {
    self.root = [[SKSpriteNode alloc] initWithColor:[UIColor orangeColor] size:CGSizeMake(10.f, 10.f)];
    self.root.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.root.size];
    self.root.physicsBody.dynamic = NO;
    self.root.position = CGPointMake(offset.x, 20.f + offset.y);
    [self.scene addChild:self.root];
    
    self.head = [[SKSpriteNode alloc] initWithColor:self.skinColor size:CGSizeMake(100, 100)];
    self.head.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.head.size];
    self.head.physicsBody.collisionBitMask = 0;
    self.head.position = CGPointMake(offset.x, offset.y);
    [self.scene addChild:self.head];
    
    SKPhysicsJointSpring *headJoint = [SKPhysicsJointSpring jointWithBodyA:self.root.physicsBody bodyB:self.head.physicsBody anchorA:self.root.position anchorB:CGPointMake(self.head.position.x, self.head.position.y+10.f)];
    [self.scene.physicsWorld addJoint:headJoint];
    
    // Eyes
    self.leftEye = [self eye];
    self.leftEye.position = CGPointMake(self.head.position.x - 20.f, self.head.position.y + 20.f);
    [self attachEye:self.leftEye];
    
    self.rightEye = [self eye];
    self.rightEye.position = CGPointMake(self.head.position.x + 20.f, self.head.position.y + 20.f);
    [self attachEye:self.rightEye];
    
    // Mouth
    self.mouth = [[SKSpriteNode alloc] initWithColor:self.featureColor size:CGSizeMake(70, 10)];
    self.mouth.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.mouth.size];
    self.mouth.physicsBody.collisionBitMask = 0;
    self.mouth.position = CGPointMake(self.head.position.x, self.head.position.y - 20.f);
    [self.scene addChild:self.mouth];
    
    SKPhysicsJointSpring *mouthJoint = [SKPhysicsJointSpring jointWithBodyA:self.head.physicsBody bodyB:self.mouth.physicsBody anchorA:self.head.position anchorB:self.mouth.position];
    [self.scene.physicsWorld addJoint:mouthJoint];
}

- (void)attachEye:(SKSpriteNode *)eye {
    SKPhysicsJointSpring *ls = [SKPhysicsJointSpring jointWithBodyA:self.head.physicsBody bodyB:eye.physicsBody anchorA:CGPointMake(eye.position.x - 10.f, eye.position.y + 10.f) anchorB:eye.position];
    SKPhysicsJointSpring *rs = [SKPhysicsJointSpring jointWithBodyA:self.head.physicsBody bodyB:eye.physicsBody anchorA:CGPointMake(eye.position.x + 10.f, eye.position.y + 10.f) anchorB:eye.position];
    
    [self.scene.physicsWorld addJoint:ls];
    [self.scene.physicsWorld addJoint:rs];
}

- (SKSpriteNode *)eye {
    SKSpriteNode *eye = [[SKSpriteNode alloc] initWithColor:self.featureColor size:CGSizeMake(20, 20)];
    eye.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:eye.size];
    eye.physicsBody.collisionBitMask = 0;
    [self.scene addChild:eye];
    return eye;
}

@end
