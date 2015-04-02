//
//  main.m
//  DeleteApp
//
//  Created by Killua Liu on 4/2/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <AppleScriptObjC/AppleScriptObjC.h>

int main(int argc, const char * argv[]) {
    [[NSBundle mainBundle] loadAppleScriptObjectiveCScripts];
    return NSApplicationMain(argc, argv);
}
