//
//  FirstViewController.swift
//  iKid
//
//  Created by Kevin Ke on 4/27/16.
//  Copyright © 2016 Kevin Ke. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    private var questionController : GoodJokeContrller!
    private var punchlineController : GoodPunchlineContrller!
    
    private func firstBuilder() {
        if questionController == nil {
            questionController = storyboard?.instantiateViewControllerWithIdentifier("GoodQuestion") as! GoodJokeContrller
        }
    }
    
    private func secondBuilder() {
        if punchlineController == nil {
            punchlineController = storyboard?.instantiateViewControllerWithIdentifier("GoodPunchline") as! GoodPunchlineContrller
        }
    }

    @IBAction func switchViews(sender: UIBarButtonItem) {
        secondBuilder()
        firstBuilder()
        
        UIView.beginAnimations("View Flip", context: nil)
        UIView.setAnimationDuration(0.4)
        UIView.setAnimationCurve(.EaseInOut)
        
        if questionController != nil &&
            questionController?.view.superview != nil {
            UIView.setAnimationTransition(.FlipFromRight, forView: view, cache: true)
            punchlineController.view.frame = view.frame
            switchViewController(questionController, to: punchlineController)
        }
        else {
            UIView.setAnimationTransition(.FlipFromLeft, forView: view, cache: true)
            questionController.view.frame = view.frame
            switchViewController(punchlineController, to: questionController)
        }
        UIView.commitAnimations()
    }
    
    private func switchViewController(from: UIViewController?, to: UIViewController?) {
        if from != nil {
            from!.willMoveToParentViewController(nil)
            from!.view.removeFromSuperview()
            from!.removeFromParentViewController()
        }
        
        if to != nil {
            self.addChildViewController(to!)
            self.view.insertSubview(to!.view, atIndex: 0)
            to!.didMoveToParentViewController(self)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        firstBuilder()
        switchViewController(nil, to: questionController)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

