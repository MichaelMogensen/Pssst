//
//  Timer.swift
//  Pssst
//
//  Created by Michael Mogensen on 03/04/15.
//  Copyright (c) 2015 Michael Mogensen. All rights reserved.
//
//  http://samuelmullen.com/2014/07/using-swifts-closures-with-nstimer/
//

import Foundation

class OnePerSecondTimer
{
    var timer = Timer()
    var handler: (Int) -> ()
    
    var duration: Int
    var elapsedTime: Int = 0
    
   /****************************************
    * Init.                                *
    ****************************************/
    
    init(duration: Int, handler: (Int) -> ())
    {
        self.duration = duration
        let dummyHandler = {(arg: Int) -> Void in
            // NOP
        }
        self.handler = dummyHandler
    }
    
    deinit
    {
        self.timer.invalidate()
    }
    
   /****************************************
    * Worker methods.                      *
    ****************************************/
    
    // Start timer.
    func Start()
    {
        // Once per second.
        self.timer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(OnePerSecondTimer.Tick),
            userInfo: nil,
            repeats: true)
    }
    // Stop timer.
    func Stop()
    {
        timer.invalidate()
    }
    // Call this handler on timeout.
    @objc func Tick()
    {
        self.elapsedTime += 1
        
        self.handler(elapsedTime)
        
        if self.elapsedTime == self.duration {
            self.Stop()
        }
    }
    
}

class NSecondsTimer
{
    fileprivate var timer = Timer()
    fileprivate var handler: (Int) -> ()
    
    fileprivate var timeout = TimeInterval(1)
    fileprivate var tickCount: Int = 0
    
   /****************************************
    * Init.                                *
    ****************************************/
    
    init(timeout: Int, handler: (Int) -> ())
    {
        self.timeout = TimeInterval(timeout)
        // self.handler = handler FIX LATER
        let dummyHandler = {(arg: Int) -> Void in
            // NOP
        }
        self.handler = dummyHandler
    }
    
    deinit
    {
        self.timer.invalidate()
    }
    
   /****************************************
    * Worker methods.                      *
    ****************************************/
    
    // Start timer.
    func Start()
    {
        // Once per self.timeout seconds.
        self.timer = Timer.scheduledTimer(
            timeInterval: self.timeout,
            target: self,
            selector: #selector(OnePerSecondTimer.Tick),
            userInfo: nil,
            repeats: true)
    }
    // Stop timer.
    func Stop()
    {
        timer.invalidate()
    }
    // Call this handler on timeout.
    @objc func Tick()
    {
        tickCount += 1
        self.handler(tickCount)
    }
    
}

