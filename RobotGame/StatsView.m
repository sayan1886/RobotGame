//
//  StatsView.m
//  Robots
//
//  Created by Diana Zmuda on 9/13/12.
//  Copyright (c) 2012 Diana Zmuda. All rights reserved.
//

#import "StatsView.h"
#import "Player.h"
#import "LevelViewController.h"
#import "ItemView.h"
#import <QuartzCore/QuartzCore.h>
#import "Item.h"
#import "DataStore.h"

@interface StatsView ()
@property UILabel *currentHP;
@property UILabel *maxHP;
@property UILabel *maxShield;
@property UILabel *eHit;
@property UILabel *mHit;
@property UILabel *pHit;
@property UILabel *ePoints;
@property UILabel *mPoints;
@property UILabel *pPoints;
@property UILabel *crit;
@property UILabel *scrap;
@property UILabel *points;
@property UILabel *level;
@property UILabel *xp;
@end

@implementation StatsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //        CALayer *bgLayer = [CALayer new];
        //        bgLayer.bounds = CGRectMake(0,0,self.window.frame.size.width,self.window.frame.size.height);
        //        bgLayer.frame = CGRectMake(0,0,self.window.frame.size.width,self.window.frame.size.height);
        //        UIImage *inventory = [UIImage imageNamed:@"inventory.png"];
        //        bgLayer.contents = (__bridge id)([inventory CGImage]);
        //        [self.layer addSublayer:bgLayer];
        
        UIImage *bgImage = [UIImage imageNamed:@"inventory.png"];
        self.backgroundColor = [UIColor colorWithPatternImage:bgImage];
    }
    return self;
}

- (void) setupView {
    //remove the old inv items
    for (UIView* view in self.subviews) {
        [view removeFromSuperview];
    }
    
    //place the buttons
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(0, 350, 50, 50);
    [button1 setImage:[UIImage imageNamed:@"ehit.png"] forState:UIControlStateNormal];
    button1.adjustsImageWhenHighlighted = NO;
    [button1 addTarget:self action:@selector(increaseEPoints) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(50, 350, 50, 50);
    [button2 setImage:[UIImage imageNamed:@"mhit.png"] forState:UIControlStateNormal];
    button2.adjustsImageWhenHighlighted = NO;
    [button2 addTarget:self action:@selector(increaseMPoints) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button2];
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    button3.frame = CGRectMake(100, 350, 50, 50);
    [button3 setImage:[UIImage imageNamed:@"phit.png"] forState:UIControlStateNormal];
    button3.adjustsImageWhenHighlighted = NO;
    [button3 addTarget:self action:@selector(increasePPoints) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button3];
    
    UIButton *button4 = [UIButton buttonWithType:UIButtonTypeCustom];
    button4.frame = CGRectMake(40, 430, 50, 50);
    [button4 setImage:[UIImage imageNamed:@"enter.png"] forState:UIControlStateNormal];
    button4.adjustsImageWhenHighlighted = NO;
    [button4 addTarget:self action:@selector(repair) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button4];
    
    UIButton *button5 = [UIButton buttonWithType:UIButtonTypeCustom];
    button5.frame = CGRectMake(270, 430, 50, 50);
    [button5 setImage:[UIImage imageNamed:@"exit.png"] forState:UIControlStateNormal];
    button5.adjustsImageWhenHighlighted = NO;
    [button5 addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button5];
    
    [self renderInventory];
    
    //place the labels
    self.currentHP = [[UILabel alloc] initWithFrame:CGRectMake(250, 260, 100, 15)];
    self.currentHP.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
    self.currentHP.font = [self.currentHP.font fontWithSize:14];
    [self addSubview:self.currentHP];
    self.maxHP = [[UILabel alloc] initWithFrame:CGRectMake(250, 275, 100, 15)];
    self.maxHP.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
    self.maxHP.font = [self.maxHP.font fontWithSize:14];
    [self addSubview:self.maxHP];
    self.maxShield = [[UILabel alloc] initWithFrame:CGRectMake(250, 290, 100, 15)];
    self.maxShield.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
    self.maxShield.font = [self.maxShield.font fontWithSize:14];
    [self addSubview:self.maxShield];
    self.crit = [[UILabel alloc] initWithFrame:CGRectMake(250, 305, 100, 15)];
    self.crit.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
    self.crit.font = [self.crit.font fontWithSize:14];
    [self addSubview:self.crit];
    
    
    
    self.scrap = [[UILabel alloc] initWithFrame:CGRectMake(250, 400, 100, 15)];
    self.scrap.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
    [self addSubview:self.scrap];
    self.scrap.font = [self.crit.font fontWithSize:14];
    self.level = [[UILabel alloc] initWithFrame:CGRectMake(250, 415, 100, 15)];
    self.level.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
    [self addSubview:self.level];
    self.level.font = [self.crit.font fontWithSize:14];
    
    
    //    self.ePoints = [[UILabel alloc] initWithFrame:CGRectMake(250, 305, 100, 15)];
    //    self.ePoints.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
    //    [self addSubview:self.ePoints];
    //    self.points = [[UILabel alloc] initWithFrame:CGRectMake(250, 320, 100, 15)];
    //    self.points.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
    //    [self addSubview:self.points];
    
    [self updateLabels];
    
}

-(void)updateLabels {
    self.currentHP.text = [NSString stringWithFormat:@"%ld", lroundf(self.lvc.player.currentHP)];
    self.maxHP.text = [NSString stringWithFormat:@"%d", self.lvc.player.maxHP];
    self.maxShield.text = [NSString stringWithFormat:@"%d", self.lvc.player.maxShield];
    self.crit.text = [NSString stringWithFormat:@"%d", self.lvc.player.crit];
    
    self.scrap.text = [NSString stringWithFormat:@"%d", self.lvc.player.scrap];
    self.level.text = [NSString stringWithFormat:@"%d", self.lvc.player.level];
    
    self.ePoints.text = [NSString stringWithFormat:@"%d", self.lvc.player.ePoints];
    self.points.text = [NSString stringWithFormat:@"%d", self.lvc.player.points];
}

-(void)increaseEPoints {
    if (self.lvc.player.points >0) {
        self.lvc.player.ePoints += 1;
        self.lvc.player.points -= 1;
        self.lvc.player.eHit += 1;
        self.lvc.player.crit += 1;
        if (self.lvc.player.ePoints == 3) {
            self.lvc.player.eBuff = TRUE;
        }
        if (self.lvc.player.ePoints == 6) {
            self.lvc.player.eMove = TRUE;
        }
        [self updateLabels];
    }
}

-(void)increaseMPoints {
    if (self.lvc.player.points >0) {
        self.lvc.player.mPoints += 1;
        self.lvc.player.points -= 1;
        self.lvc.player.mHit += 1;
        self.lvc.player.maxShield += 1;
        if (self.lvc.player.mPoints == 3) {
            self.lvc.player.mBuff = TRUE;
        }
        if (self.lvc.player.mPoints == 6) {
            self.lvc.player.mMove = TRUE;
        }
        [self updateLabels];
    }
}

-(void)increasePPoints {
    if (self.lvc.player.points >0) {
        self.lvc.player.pPoints += 1;
        self.lvc.player.points -= 1;
        self.lvc.player.pHit += 1;
        self.lvc.player.maxHP += 2;
        if (self.lvc.player.mPoints == 3) {
            self.lvc.player.mBuff = TRUE;
        }
        if (self.lvc.player.mPoints == 6) {
            self.lvc.player.mMove = TRUE;
        }
        [self updateLabels];
    }
}

-(void)repair {
    double damage = self.lvc.player.maxHP - self.lvc.player.currentHP;
    if (self.lvc.player.scrap >= .5*damage) {
        self.lvc.player.scrap -= .5*damage;
        self.lvc.player.currentHP = self.lvc.player.maxHP;
    } else {
        double affordableRepair = self.lvc.player.scrap / .5;
        self.lvc.player.scrap = 0;
        self.lvc.player.currentHP += affordableRepair;
    }
    [self updateLabels];
}

-(void)dismiss {
    [DataStore save];
    [self.lvc dismissModalViewControllerAnimated:YES];
}

-(void)renderInventory {
    
    //the rects for checking if you drag into arm slots
    self.left = CGRectMake(120, 200, 50, 50);
    self.right = CGRectMake(180, 200, 50, 50);
    
    //render the images in the arm slots
//    UIView *leftView = [[UIView alloc] initWithFrame:self.left];
//    UIImage *leftViewItem = [UIImage imageNamed:@"phit.png"];
//    if (self.lvc.player.leftArm.type == 1) {
//        leftViewItem = [UIImage imageNamed:@"ehit.png"];
//    } else if (self.lvc.player.leftArm.type == 2) {
//        leftViewItem = [UIImage imageNamed:@"mhit.png"];
//    }
//    leftView.backgroundColor = [UIColor colorWithPatternImage:leftViewItem];
//    [self addSubview:leftView];
//    
//    UIView *rightView = [[UIView alloc] initWithFrame:self.right];
//    UIImage *rightViewItem = [UIImage imageNamed:@"phit.png"];
//    if (self.lvc.player.rightArm.type == 1) {
//        rightViewItem = [UIImage imageNamed:@"ehit.png"];
//    } else if (self.lvc.player.rightArm.type == 2) {
//        rightViewItem = [UIImage imageNamed:@"mhit.png"];
//    }
//    rightView.backgroundColor = [UIColor colorWithPatternImage:rightViewItem];
//    [self addSubview:rightView];
    
    [self.lvc.player.leftArm setupLayer];
    self.lvc.player.leftArm.layer.frame = self.left;
    [self.layer addSublayer:self.lvc.player.leftArm.layer];
    
    [self.lvc.player.rightArm setupLayer];
    self.lvc.player.rightArm.layer.frame = self.right;
    [self.layer addSublayer:self.lvc.player.rightArm.layer];
    
    //render the draggable items that are in your inventory
    if (self.lvc.player.inv1) {
        self.inv1Item = [[ItemView alloc] initWithFrame:CGRectMake(60, 40, 50, 50) andItem:self.lvc.player.inv1 andSV:self];
        [self addSubview:self.inv1Item];
    }if (self.lvc.player.inv2) {
         self.inv2Item = [[ItemView alloc] initWithFrame:CGRectMake(120, 40, 50, 50) andItem:self.lvc.player.inv2 andSV:self];
        [self addSubview:self.inv2Item];
    } if (self.lvc.player.inv3) {
        self.inv3Item = [[ItemView alloc] initWithFrame:CGRectMake(180, 40, 50, 50) andItem:self.lvc.player.inv3 andSV:self];
        [self addSubview:self.inv3Item];
    } if (self.lvc.player.inv4) {
        self.inv4Item = [[ItemView alloc] initWithFrame:CGRectMake(240, 40, 50, 50) andItem:self.lvc.player.inv4 andSV:self];
        [self addSubview:self.inv4Item];
    }
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
