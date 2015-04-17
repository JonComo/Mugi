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
        _featureColor = [UIColor whiteColor];
        _skinColor = [UIColor blackColor];
        
        [self constructFaceOffset:offset];
    }
    
    return self;
}

- (void)constructFaceOffset:(CGPoint)offset {
    self.root = [[SKSpriteNode alloc] initWithColor:[UIColor orangeColor] size:CGSizeMake(10.f, 10.f)];
    self.root.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.root.size];
    self.root.physicsBody.dynamic = NO;
    self.root.position = offset;
    [self.scene addChild:self.root];
    
    self.head = [[SKSpriteNode alloc] initWithColor:self.skinColor size:CGSizeMake(240, 240)];
    self.head.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.head.size];
    self.head.physicsBody.collisionBitMask = 0;
    //self.head.physicsBody.mass = 0.1f;
    self.head.position = CGPointMake(offset.x, offset.y);
    [self.scene addChild:self.head];
    
    // Head joints
    CGFloat headJointOffset = 40.f;
    SKPhysicsJointSpring *hl = [SKPhysicsJointSpring jointWithBodyA:self.root.physicsBody bodyB:self.head.physicsBody anchorA:CGPointMake(self.root.position.x - headJointOffset, self.root.position.y + headJointOffset) anchorB:CGPointMake(self.head.position.x - headJointOffset/2.f, self.head.position.y + headJointOffset/2.f)];
    SKPhysicsJointSpring *hr = [SKPhysicsJointSpring jointWithBodyA:self.root.physicsBody bodyB:self.head.physicsBody anchorA:CGPointMake(self.root.position.x + headJointOffset, self.root.position.y + headJointOffset) anchorB:CGPointMake(self.head.position.x + headJointOffset/2.f, self.head.position.y + headJointOffset/2.f)];
    [self.scene.physicsWorld addJoint:hl];
    [self.scene.physicsWorld addJoint:hr];
    
    // Eyes
    CGFloat eyeOffset = 60.f;
    self.leftEye = [self eye];
    self.leftEye.position = CGPointMake(self.head.position.x - eyeOffset, self.head.position.y + eyeOffset);
    [self attachEye:self.leftEye];
    
    self.rightEye = [self eye];
    self.rightEye.position = CGPointMake(self.head.position.x + eyeOffset, self.head.position.y + eyeOffset);
    [self attachEye:self.rightEye];
    
    // Mouth
    self.mouth = [[SKSpriteNode alloc] initWithColor:self.featureColor size:CGSizeMake(100, 30)];
    self.mouth.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.mouth.size];
    self.mouth.physicsBody.collisionBitMask = 0;
    self.mouth.position = CGPointMake(self.head.position.x, self.head.position.y - 40.f);
    [self.scene addChild:self.mouth];
    
    // Mouth joints
    SKPhysicsJointSpring *ml = [SKPhysicsJointSpring jointWithBodyA:self.head.physicsBody bodyB:self.mouth.physicsBody anchorA:CGPointMake(self.head.position.x - 100.f, self.head.position.y + 20.f) anchorB:CGPointMake(self.mouth.position.x - self.mouth.size.width/2.f, self.mouth.position.y + 20.f)];
    SKPhysicsJointSpring *mr = [SKPhysicsJointSpring jointWithBodyA:self.head.physicsBody bodyB:self.mouth.physicsBody anchorA:CGPointMake(self.head.position.x + 100.f, self.head.position.y + 20.f) anchorB:CGPointMake(self.mouth.position.x + self.mouth.size.width/2.f, self.mouth.position.y + 20.f)];
    [self.scene.physicsWorld addJoint:ml];
    [self.scene.physicsWorld addJoint:mr];
}

- (void)attachEye:(SKSpriteNode *)eye {
    SKPhysicsJointSpring *ls = [SKPhysicsJointSpring jointWithBodyA:self.head.physicsBody bodyB:eye.physicsBody anchorA:CGPointMake(eye.position.x - 20.f, eye.position.y + 20.f) anchorB:CGPointMake(eye.position.x - 10.f, eye.position.y + 10.f)];
    SKPhysicsJointSpring *rs = [SKPhysicsJointSpring jointWithBodyA:self.head.physicsBody bodyB:eye.physicsBody anchorA:CGPointMake(eye.position.x + 20.f, eye.position.y + 20.f) anchorB:CGPointMake(eye.position.x + 10.f, eye.position.y + 10.f)];
    
    [self.scene.physicsWorld addJoint:ls];
    [self.scene.physicsWorld addJoint:rs];
}

- (SKSpriteNode *)eye {
    SKSpriteNode *eye = [[SKSpriteNode alloc] initWithColor:self.featureColor size:CGSizeMake(60, 60)];
    eye.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:eye.size];
    eye.physicsBody.collisionBitMask = 0;
    [self.scene addChild:eye];
    
    SKSpriteNode *pupil = [[SKSpriteNode alloc] initWithColor:[UIColor blackColor] size:CGSizeMake(50, 50)];
    pupil.position = CGPointMake(eye.position.x, eye.position.y + 10.f);
    pupil.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:pupil.size];
    pupil.physicsBody.collisionBitMask = 0;
    [self.scene addChild:pupil];
    
    SKPhysicsJointSliding *pupilJoint = [SKPhysicsJointSliding jointWithBodyA:eye.physicsBody bodyB:pupil.physicsBody anchor:eye.position axis:CGVectorMake(0.f, 10.f)];
    pupilJoint.shouldEnableLimits = YES;
    pupilJoint.lowerDistanceLimit = 0.f;
    pupilJoint.upperDistanceLimit = 10.f;
    [self.scene.physicsWorld addJoint:pupilJoint];
    
    return eye;
}

@end
