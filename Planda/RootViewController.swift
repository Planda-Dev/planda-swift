//
//  RootViewController.swift
//  Planda
//
//  Created by Prince Carter on 2/1/20.
//  Copyright © 2020 Prince Carter. All rights reserved.
//

import UIKit
import EMPageViewController

class RootViewController: UIViewController, EMPageViewControllerDataSource, EMPageViewControllerDelegate {
    
    var pageViewController: EMPageViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Instantiate EMPageViewController and set the data source and delegate to 'self'
        let pageViewController = EMPageViewController()
        
        // Or, for a vertical orientation
        // let pageViewController = EMPageViewController(navigationOrientation: .Vertical)
        
        pageViewController.dataSource = self
        pageViewController.delegate = self
        
        // Set the initially selected view controller
        // IMPORTANT: If you are using a dataSource, make sure you set it BEFORE calling selectViewController:direction:animated:completion
        let currentViewController = self.viewController(at: 0)!
        pageViewController.selectViewController(currentViewController, direction: .forward, animated: false, completion: nil)
        
        // Add EMPageViewController to the root view controller
        self.addChild(pageViewController)
        self.view.insertSubview(pageViewController.view, at: 0) // Insert the page controller view below the navigation buttons
        pageViewController.didMove(toParent: self)
        
        self.pageViewController = pageViewController
        
    }
    
    // MARK: - EMPageViewController Data Source
    
    func em_pageViewController(_ pageViewController: EMPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        if let viewControllerIndex = self.index(of: viewController as! TripTableViewController) {
            let beforeViewController = self.viewController(at: viewControllerIndex - 1)
            return beforeViewController
        } else {
            return nil
        }
    }
    
    func em_pageViewController(_ pageViewController: EMPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        if let viewControllerIndex = self.index(of: viewController as! TripTableViewController) {
            let afterViewController = self.viewController(at: viewControllerIndex + 1)
            return afterViewController
        } else {
            return nil
        }
    }
    
    func viewController(at index: Int) -> TripTableViewController? {
        let viewController = self.storyboard!.instantiateViewController(withIdentifier: "TripTableViewController") as! TripTableViewController
        return viewController
    }
    
    func index(of viewController: TripTableViewController) -> Int? {
//        if let greeting: String = viewController.greeting {
//            return self.greetings.firstIndex(of: greeting)
//        } else {
//            return nil
//        }
        return 2
    }
    
    
    // MARK: - EMPageViewController Delegate

//    func em_pageViewController(_ pageViewController: EMPageViewController, willStartScrollingFrom startViewController: UIViewController, destinationViewController: UIViewController) {
//        
//        let startGreetingViewController = startViewController as! TripTableViewController
//        let destinationGreetingViewController = destinationViewController as! TripTableViewController
//    
//    }
    
//    func em_pageViewController(_ pageViewController: EMPageViewController, isScrollingFrom startViewController: UIViewController, destinationViewController: UIViewController, progress: CGFloat) {
//        let startGreetingViewController = startViewController as! TripTableViewController
//        let destinationGreetingViewController = destinationViewController as! TripTableViewController
//
//        // Ease the labels' alphas in and out
//        let absoluteProgress = abs(progress)
//        startGreetingViewController.label.alpha = pow(1 - absoluteProgress, 2)
//        destinationGreetingViewController.label.alpha = pow(absoluteProgress, 2)
//
//       print("Is scrolling from \(startGreetingViewController.greeting!) to \(destinationGreetingViewController.greeting!) with progress '\(progress)'.")
//    }
    
//    func em_pageViewController(_ pageViewController: EMPageViewController, didFinishScrollingFrom startViewController: UIViewController?, destinationViewController: UIViewController, transitionSuccessful: Bool) {
//        let startViewController = startViewController as! GreetingViewController?
//        let destinationViewController = destinationViewController as! GreetingViewController
//
//        // If the transition is successful, the new selected view controller is the destination view controller.
//        // If it wasn't successful, the selected view controller is the start view controller
//        if transitionSuccessful {
//
//            if (self.index(of: destinationViewController) == 0) {
//                self.reverseButton.isEnabled = false
//            } else {
//                self.reverseButton.isEnabled = true
//            }
//
//            if (self.index(of: destinationViewController) == self.greetings.count - 1) {
//                self.forwardButton.isEnabled = false
//            } else {
//                self.forwardButton.isEnabled = true
//            }
//        }
//
//        print("Finished scrolling from \(startViewController != nil ? startViewController!.greeting! : "nil") to \(destinationViewController.greeting!). Transition successful? \(transitionSuccessful)")
//    }

}
