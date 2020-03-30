//
//  CreateEventController.swift
//  Planda
//
//  Created by Prince Carter on 1/23/20.
//  Copyright © 2020 Prince Carter. All rights reserved.
//

import UIKit
import YNSearch

class YNDropDownMenu: YNSearchModel {
    var starCount = 512
    var description = "Awesome Dropdown menu for iOS with Swift 3"
    var version = "2.3.0"
    var url = "https://github.com/younatics/YNDropDownMenu"
}

class YNSearchData: YNSearchModel {
    var title = "YNSearch"
    var starCount = 271
    var description = "Awesome fully customize search view like Pinterest written in Swift 3"
    var version = "0.3.1"
    var url = "https://github.com/younatics/YNSearch"
}

class YNExpandableCell: YNSearchModel {
    var title = "YNExpandableCell"
    var starCount = 191
    var description = "Awesome expandable, collapsible tableview cell for iOS written in Swift 3"
    var version = "1.1.0"
    var url = "https://github.com/younatics/YNExpandableCell"
}

class CreateEventController: YNSearchViewController, YNSearchDelegate {
    
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var scrollToButton: UIButton!
    @IBOutlet weak var reverseButton: UIButton!
    
    var greetings: [String] = ["Hello!", "¡Hola!", "Salut!", "Hallo!", "Ciao!"]
    var greetingColors: [UIColor] = [
        UIColor(red: 108.0/255.0, green: 122.0/255.0, blue: 137.0/255.0, alpha: 1.0),
        UIColor(red: 135.0/255.0, green: 211.0/255.0, blue: 124.0/255.0, alpha: 1.0),
        UIColor(red: 34.0/255.0, green: 167.0/255.0, blue: 240.0/255.0, alpha: 1.0),
        UIColor(red: 245.0/255.0, green: 171.0/255.0, blue: 53.0/255.0, alpha: 1.0),
        UIColor(red: 214.0/255.0, green: 69.0/255.0, blue: 65.0/255.0, alpha: 1.0)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let popGestureRecognizer = self.navigationController!.interactivePopGestureRecognizer!
        if let targets = popGestureRecognizer.value(forKey: "targets") as? NSMutableArray {
          let gestureRecognizer = UIPanGestureRecognizer()
          gestureRecognizer.setValue(targets, forKey: "targets")
          self.view.addGestureRecognizer(gestureRecognizer)
        }
        
        let demoCategories = ["Sunny", "Beachy", "Cheap", "Touristy", "Good Food", "Adventurous", "Hiking", "Kids", "Drinking"]
        //let demoSearchHistories = ["Menu", "Animation", "Transition", "TableView"]
        
        let ynSearch = YNSearch()
        ynSearch.setCategories(value: demoCategories)
        
        self.ynSearchinit()
        
        self.delegate = self
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        let database1 = YNDropDownMenu(key: "YNDropDownMenu")
        let database2 = YNSearchData(key: "YNSearchData")
        let database3 = YNExpandableCell(key: "YNExpandableCell")
        let demoDatabase = [database1, database2, database3]
        
        self.initData(database: demoDatabase)
        self.setYNCategoryButtonType(type: .colorful)
        ynSearchTextfieldView.ynSearchTextField.placeholder = "Ever Been To Mexico?"
        ynSearchView.ynSearchMainView.searchHistoryLabel.isHidden = true
        
    }
    
    func ynSearchListViewDidScroll() {
        self.ynSearchTextfieldView.ynSearchTextField.endEditing(true)
    }
    

    func ynSearchHistoryButtonClicked(text: String) {
        self.pushViewController(text: text)
        print(text)
    }
    
    func ynCategoryButtonClicked(text: String) {
        self.pushViewController(text: text)
        print(text)
    }
    
    func ynSearchListViewClicked(key: String) {
        self.pushViewController(text: key)
        print(key)
    }
    
    func ynSearchListViewClicked(object: Any) {
        print(object)
    }
    
    func ynSearchListView(_ ynSearchListView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.ynSearchView.ynSearchListView.dequeueReusableCell(withIdentifier: YNSearchListViewCell.ID) as! YNSearchListViewCell
        if let ynmodel = self.ynSearchView.ynSearchListView.searchResultDatabase[indexPath.row] as? YNSearchModel {
            cell.searchLabel.text = ynmodel.key
        }
        
        return cell
    }
    
    func ynSearchListView(_ ynSearchListView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let ynmodel = self.ynSearchView.ynSearchListView.searchResultDatabase[indexPath.row] as? YNSearchModel, let key = ynmodel.key {
            self.ynSearchView.ynSearchListView.ynSearchListViewDelegate?.ynSearchListViewClicked(key: key)
            self.ynSearchView.ynSearchListView.ynSearchListViewDelegate?.ynSearchListViewClicked(object: self.ynSearchView.ynSearchListView.database[indexPath.row])
            self.ynSearchView.ynSearchListView.ynSearch.appendSearchHistories(value: key)
        }
    }
    
    func pushViewController(text:String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "FlightDetails")
        //vc.clickedText = text
        //self.present(vc, animated: true, completion: nil)
        self.show(vc, sender: self)
    }

          // Instantiate EMPageViewController and set the data source and delegate to 'self'
//          let pageViewController = EMPageViewController()
//
//          // Or, for a vertical orientation
//          // let pageViewController = EMPageViewController(navigationOrientation: .Vertical)
//
//          pageViewController.dataSource = self
//          pageViewController.delegate = self
//
//          // Set the initially selected view controller
//          // IMPORTANT: If you are using a dataSource, make sure you set it BEFORE calling selectViewController:direction:animated:completion
//        let currentViewController = self.viewController(at: 0)!
//          pageViewController.selectViewController(currentViewController, direction: .forward, animated: false, completion: nil)
//
//          // Add EMPageViewController to the root view controller
//          self.addChild(pageViewController)
//          self.view.insertSubview(pageViewController.view, at: 1) // Insert the page controller view below the navigation buttons
//          pageViewController.didMove(toParent: self)
//
//          self.pageViewController = pageViewController
    }
    
//    // MARK: - EMPageViewController Data Source
//
//    func em_pageViewController(_ pageViewController: EMPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
//        if let viewControllerIndex = self.index(of: viewController as! DestinationController) {
//            let beforeViewController = self.viewController(at: viewControllerIndex - 1)
//            return beforeViewController
//        } else {
//            return nil
//        }
//    }
//
//    func em_pageViewController(_ pageViewController: EMPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
//        if let viewControllerIndex = self.index(of: viewController as! DestinationController) {
//            let afterViewController = self.viewController(at: viewControllerIndex + 1)
//            return afterViewController
//        } else {
//            return nil
//        }
//    }
//
//    func viewController(at index: Int) -> DestinationController? {
//        if (self.greetings.count == 0) || (index < 0) || (index >= self.greetings.count) {
//            return nil
//        }
//
//        let viewController = self.storyboard!.instantiateViewController(withIdentifier: "DestinationController") as! DestinationController
//        viewController.greeting = self.greetings[index]
//        viewController.color = self.greetingColors[index]
//        return viewController
//    }
//
//    func index(of viewController: DestinationController) -> Int? {
//        if let greeting: String = viewController.greeting {
//            return self.greetings.firstIndex(of: greeting)
//        } else {
//            return nil
//        }
//    }
//
//
//    // MARK: - EMPageViewController Delegate
//
//    func em_pageViewController(_ pageViewController: EMPageViewController, willStartScrollingFrom startViewController: UIViewController, destinationViewController: UIViewController) {
//
//        let startGreetingViewController = startViewController as! DestinationController
//        let destinationGreetingViewController = destinationViewController as! DestinationController
//
//        print("Will start scrolling from \(startGreetingViewController.greeting!) to \(destinationGreetingViewController.greeting!).")
//    }
//
//    func em_pageViewController(_ pageViewController: EMPageViewController, isScrollingFrom startViewController: UIViewController, destinationViewController: UIViewController, progress: CGFloat) {
//        let startGreetingViewController = startViewController as! DestinationController
//        let destinationGreetingViewController = destinationViewController as! DestinationController
//
//        // Ease the labels' alphas in and out
//        let absoluteProgress = abs(progress)
//        startGreetingViewController.label.alpha = pow(1 - absoluteProgress, 2)
//        destinationGreetingViewController.label.alpha = pow(absoluteProgress, 2)
//
//       print("Is scrolling from \(startGreetingViewController.greeting!) to \(destinationGreetingViewController.greeting!) with progress '\(progress)'.")
//    }
//
//    func em_pageViewController(_ pageViewController: EMPageViewController, didFinishScrollingFrom startViewController: UIViewController?, destinationViewController: UIViewController, transitionSuccessful: Bool) {
//        let startViewController = startViewController as! DestinationController?
//        let destinationViewController = destinationViewController as! DestinationController
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

