//
//  AppDelegate.m
//  HermesMacOSTestApp
//
//  Created by Eloy Durán on 24/04/2020.
//  Copyright © 2020 Eloy Durán. All rights reserved.
//

#import "AppDelegate.h"

#import <hermes/hermes.h>
#import <jsi/jsi.h>

using namespace facebook;

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    auto jsiBuffer = std::make_shared<jsi::StringBuffer>("1 + 1");
    auto runtime = facebook::hermes::makeHermesRuntime();

    try {
        auto js = runtime->prepareJavaScript(jsiBuffer, "<eval>");
        auto result = runtime->evaluatePreparedJavaScript(js);
        NSLog(@"%s", result.toString(*runtime).utf8(*runtime).c_str());
    } catch (const jsi::JSIException &e) {
        NSLog(@"JavaScript terminated via uncaught exception: %s", e.what());
    }
}

@end
