//
//  ContainerController.swift
//  Planda
//
//  Created by Prince Carter on 12/30/19.
//  Copyright © 2019 Prince Carter. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class ContainerController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let left = self.storyboard?.instantiateViewController(identifier: "left") as! ViewController
        self.addChild(left)
        self.scrollView.addSubview(left.view)
        self.didMove(toParent: self)
        
        
        left.view.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        
//        var leftFrame: CGRect = left.view.frame
//        leftFrame.origin.x = self.view.frame.width
//        right.view.frame = rightFrame
        
        let right = self.storyboard?.instantiateViewController(identifier: "right") as! RightController
        self.addChild(right)
        
                right.view.frame = CGRect(x: view.frame.width, y: 0, width: view.frame.width, height: view.frame.height)
        self.scrollView.addSubview(right.view)
        self.didMove(toParent: self)
        
        var rightFrame: CGRect = right.view.frame
        rightFrame.origin.x = self.view.frame.width
        right.view.frame = rightFrame
        
        self.scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        self.scrollView.contentSize = CGSize(width: (self.view.frame.width) * 2, height: (self.view.frame.height))
    }
}
