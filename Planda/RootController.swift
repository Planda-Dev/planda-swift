//
//  RootController.swift
//  Planda
//
//  Created by Prince Carter on 2/1/20.
//  Copyright © 2020 Prince Carter. All rights reserved.
//

import UIKit
import Pageboy

class RootController: PageboyViewController {

    lazy var viewControllers: [UIViewController] = {
        var viewControllers = [UIViewController]()
        for i in 0 ..< 5 {
            viewControllers.append(makeChildViewController(at: i))
        }
        return viewControllers
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self

        // Do any additional setup after loading the view.
    }
    
    // MARK: View Controllers
    
    func makeChildViewController(at index: Int?) -> UserTripsController {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        return storyboard.instantiateViewController(withIdentifier: "UserTripsController") as! UserTripsController
    }

}

// MARK: PageboyViewControllerDataSource
extension RootController: PageboyViewControllerDataSource {
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        let count = viewControllers.count
//        statusView.numberOfPages = count
        return count
    }
    
    func viewController(for pageboyViewController: PageboyViewController,
                        at index: PageboyViewController.PageIndex) -> UIViewController? {
        guard viewControllers.isEmpty == false else {
            return nil
        }
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
}

// MARK: PageboyViewControllerDelegate
extension RootController: PageboyViewControllerDelegate {
    func pageboyViewController(_ pageboyViewController: PageboyViewController,
                               willScrollToPageAt index: PageboyViewController.PageIndex,
                               direction: PageboyViewController.NavigationDirection,
                               animated: Bool) {
//        print("willScrollToPageAtIndex: \(index)")
    }
    
    func pageboyViewController(_ pageboyViewController: PageboyViewController,
                               didCancelScrollToPageAt index: PageboyViewController.PageIndex,
                               returnToPageAt previousIndex: PageboyViewController.PageIndex) {
//        print("didCancelScrollToPageAt: \(index), returnToPageAt: \(previousIndex)")
    }
    
    func pageboyViewController(_ pageboyViewController: PageboyViewController,
                               didScrollTo position: CGPoint,
                               direction: PageboyViewController.NavigationDirection,
                               animated: Bool) {
//        print("didScrollToPosition: \(position)")
        
        let relativePosition = navigationOrientation == .vertical ? position.y : position.x
//        gradient?.gradientOffset = relativePosition
//        statusView.currentPosition = relativePosition
//
//        updateBarButtonsForCurrentIndex()
    }
    
    func pageboyViewController(_ pageboyViewController: PageboyViewController,
                               didScrollToPageAt index: PageboyViewController.PageIndex,
                               direction: PageboyViewController.NavigationDirection,
                               animated: Bool) {
//        print("didScrollToPageAtIndex: \(index)")

//        gradient?.gradientOffset = CGFloat(index)
//        statusView.currentIndex = index
//        updateBarButtonsForCurrentIndex()
    }
    
    func pageboyViewController(_ pageboyViewController: PageboyViewController,
                               didReloadWith currentViewController: UIViewController,
                               currentPageIndex: PageIndex) {
    }
}
