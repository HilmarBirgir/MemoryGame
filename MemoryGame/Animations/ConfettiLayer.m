//
//  ConfettiLayer.m
//  MemoryGame
//
//  Created by Hilmar Birgir Ólafsson on 18/12/2016.
//  Copyright © 2016 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "ConfettiLayer.h"

#import <QuartzCore/QuartzCore.h>

static NSTimeInterval const DECAY_STEP_INTERVAL = 0.1;

@interface ConfettiLayer ()

@property (readwrite, nonatomic) __weak CAEmitterLayer *effectEmitter;
@property (readwrite, nonatomic) CGFloat decayAmount;

@end

@implementation ConfettiLayer

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setupConfetti];
        [self setupAnimationControl];
    }
    
    return self;
}

- (void)setupConfetti
{
    self.userInteractionEnabled = NO;
    self.backgroundColor = [UIColor clearColor];
    self.effectEmitter = (CAEmitterLayer *)self.layer;
    self.effectEmitter.emitterPosition = CGPointMake(self.bounds.size.width * 0.5, 0);
    self.effectEmitter.emitterSize = CGSizeMake(self.bounds.size.width, 0);
    self.effectEmitter.emitterShape = kCAEmitterLayerLine;
    
    CAEmitterCell *confetti = [CAEmitterCell emitterCell];
    confetti.contents = (__bridge id)[[UIImage imageNamed:@"Confetti"] CGImage];
    confetti.name = @"confetti";
    confetti.birthRate = 0;
    confetti.lifetime = 5.0;
    confetti.color = [[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0] CGColor];
    confetti.redRange = 0.8;
    confetti.blueRange = 0.8;
    confetti.greenRange = 0.8;
    
    confetti.velocity = 150;
    confetti.velocityRange = 50;
    confetti.emissionRange = (CGFloat) M_PI_2;
    confetti.emissionLongitude = (CGFloat) M_PI;
    confetti.yAcceleration = 150;
    confetti.scale = 0.5;
    confetti.scaleRange = 0.2;
    confetti.spinRange = 10.0;
    self.effectEmitter.emitterCells = @[confetti];
    
    self.effectEmitter.beginTime = CACurrentMediaTime();
}

- (void)setupAnimationControl
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"emitterCells.confetti.birthRate"];
    animation.fromValue = @(200.0);
    animation.toValue = @(0.0);
    [animation setTimingFunction:[CAMediaTimingFunction functionWithControlPoints:1.5 :1.0 :.5 :2.0]];
    animation.duration = 3;
    animation.fillMode = kCAFillModeBackwards;
    animation.removedOnCompletion = NO;
    [self.effectEmitter addAnimation:animation forKey:@"emitterAnim"];
}

+ (Class) layerClass
{
    return [CAEmitterLayer class];
}

- (void)decayStep
{
    self.effectEmitter.birthRate -= self.decayAmount;
    
    if (self.effectEmitter.birthRate < 0)
    {
        self.effectEmitter.birthRate = 0;
    }
    else
    {
        [self performSelector:@selector(decayStep)
                   withObject:nil
                   afterDelay:DECAY_STEP_INTERVAL];
    }
}

- (void)decayOverTime:(NSTimeInterval)interval
{
    self.decayAmount = (CGFloat) (self.effectEmitter.birthRate /  (interval / DECAY_STEP_INTERVAL));
    [self decayStep];
}

- (void) stopEmitting
{
    self.effectEmitter.birthRate = 0.0;
}

@end
