//
//  ViewController.swift
//  PhotoCarousel
//
//  Created by Georgiev, Veliyan on 3/7/17.
//  Copyright © 2017 VillyG. All rights reserved.
//

import UIKit

class MainController: UIViewController {

    
    let image1: UIImage = UIImage.create(fromColor: UIColor.blue)
    let image2: UIImage = UIImage.create(fromColor: UIColor.red)
    let image3: UIImage = UIImage.create(fromColor: UIColor.yellow)
    
    var carousel: UIView = {
        
        let result = UIView()
        result.translatesAutoresizingMaskIntoConstraints = false
        result.backgroundColor = UIColor.purple
        return result
        
    }()
    
    var commonConstraints: [NSLayoutConstraint] = []
    var landscapeConstraints: [NSLayoutConstraint] = []
    var portraitConstraints: [NSLayoutConstraint] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(carousel)

        commonConstraints.append(NSLayoutConstraint(item: carousel, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0))
        commonConstraints.append(NSLayoutConstraint(item: carousel, attribute: .top, relatedBy: .equal, toItem: self.topLayoutGuide, attribute: .bottom, multiplier: 1.0, constant: 0))
        commonConstraints.append(NSLayoutConstraint(item: carousel, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0))
        
        portraitConstraints.append(NSLayoutConstraint(item: carousel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: self.view.bounds.height / 3))
        
        landscapeConstraints.append(NSLayoutConstraint(item: carousel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: self.view.bounds.height))
        

        NSLayoutConstraint.activate(commonConstraints)
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }

    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        print(#function)
        if traitCollection.verticalSizeClass != previousTraitCollection?.verticalSizeClass {
        
            if traitCollection.verticalSizeClass == .regular {
                NSLayoutConstraint.deactivate(landscapeConstraints)
                NSLayoutConstraint.activate(portraitConstraints)
            } else {
                NSLayoutConstraint.deactivate(portraitConstraints)
                NSLayoutConstraint.activate(landscapeConstraints)
            }
        }
        
    }
    
    

    
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        
        coordinator.animate(alongsideTransition: { (context) in
            
            if newCollection.verticalSizeClass == .regular {
                print("regular vertical")
//                self.view.backgroundColor = UIColor.red
            } else {
                print("compact vertical")
//                self.view.backgroundColor = UIColor.green
            }
            
        }) { (context) in
//            self.view.backgroundColor = UIColor.blue
        }
        
    }
    
//
//
//
//    
//    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//        super.viewWillTransition(to: size, with: coordinator)
//        
//        
//        coordinator.animate(alongsideTransition: { (context: UIViewControllerTransitionCoordinatorContext) in
//            
//            
////            self.tableView.endUpdates()
//            
//        }) { (context: UIViewControllerTransitionCoordinatorContext) in
//            
//            
//        }
//        
//    }


}

