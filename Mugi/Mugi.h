//
//  Mugi.h
//  Mugi
//
//  Created by Jon Como on 4/17/15.
//  Copyright (c) 2015 Jon Como. All rights reserved.
//

#import <Foundation/Foundation.h>

@import SpriteKit;

@interface Mugi : NSObject

// Parts
@property (nonatomic, strong) SKSpriteNode *root;
@property (nonatomic, strong) SKSpriteNode *head;
@property (nonatomic, strong) SKSpriteNode *leftEye;
@property (nonatomic, strong) SKSpriteNode *rightEye;
@property (nonatomic, strong) SKSpriteNode *mouth;

-(instancetype)initWithScene:(SKScene *)scene offset:(CGPoint)offset;

@end
