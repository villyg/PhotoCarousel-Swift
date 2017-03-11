//
//  ViewController.swift
//  PhotoCarousel
//
//  Created by Georgiev, Veliyan on 3/7/17.
//  Copyright © 2017 VillyG. All rights reserved.
//

import UIKit

class MainController: UIViewController {
    
    
    var images: [UIImage] = {

        let image1: UIImage = UIImage(named: "image1")!
        let image2: UIImage = UIImage(named: "image2")!
        let image3: UIImage = UIImage(named: "image3")!
        let image4: UIImage = UIImage(named: "image4")!
        
        var result: [UIImage] = []
        result.append(image1)
        result.append(image2)
        result.append(image3)
        result.append(image4)
        
        return result
        
    }()
    
    
    var collectionView: UICollectionView = {
        
        let frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let result = UICollectionView(frame: frame, collectionViewLayout: layout)
        result.backgroundColor = UIColor.darkGray
        result.isPagingEnabled = true
        result.translatesAutoresizingMaskIntoConstraints = false
        
        
        return result
        
    }()
    
    var tempImageView: UIImageView = {
    
        let result = UIImageView()
        result.contentMode = .scaleAspectFill
        result.clipsToBounds = true
        result.translatesAutoresizingMaskIntoConstraints = false
        result.isHidden = true
        return result
        
    }()
    
    
    var commonConstraints: [NSLayoutConstraint] = []
    var landscapeConstraints: [NSLayoutConstraint] = []
    var portraitConstraints: [NSLayoutConstraint] = []
    
    var firstTimeSetup: Bool = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.reuseIdentifer)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.addSubview(collectionView)
        self.view.addSubview(tempImageView)
        
    }
    
    
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        print(#function)
        
        
        if !firstTimeSetup {
            
            // collection view
            commonConstraints.append(NSLayoutConstraint(item: collectionView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0))
            commonConstraints.append(NSLayoutConstraint(item: collectionView, attribute: .top, relatedBy: .equal, toItem: self.topLayoutGuide, attribute: .bottom, multiplier: 1.0, constant: 0))
            commonConstraints.append(NSLayoutConstraint(item: collectionView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0))
            
            portraitConstraints.append(NSLayoutConstraint(item: collectionView, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 0.33, constant: 0))
            
            landscapeConstraints.append(NSLayoutConstraint(item: collectionView, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 1.0, constant: 0))
            
            // temp image view
            commonConstraints.append(NSLayoutConstraint(item: tempImageView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0))
            commonConstraints.append(NSLayoutConstraint(item: tempImageView, attribute: .top, relatedBy: .equal, toItem: self.topLayoutGuide, attribute: .bottom, multiplier: 1.0, constant: 0))
            commonConstraints.append(NSLayoutConstraint(item: tempImageView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0))
            
            portraitConstraints.append(NSLayoutConstraint(item: tempImageView, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 0.33, constant: 0))
            
            landscapeConstraints.append(NSLayoutConstraint(item: tempImageView, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 1.0, constant: 0))
            
            
            NSLayoutConstraint.activate(commonConstraints)
            
            firstTimeSetup = true
        
        }
        
        
        
        if traitCollection.verticalSizeClass != previousTraitCollection?.verticalSizeClass {
        
            
            NSLayoutConstraint.deactivate(landscapeConstraints)
            NSLayoutConstraint.deactivate(portraitConstraints)
            
            if traitCollection.verticalSizeClass == .regular {
                
                NSLayoutConstraint.activate(portraitConstraints)
            } else {
                NSLayoutConstraint.activate(landscapeConstraints)
            }
            
            self.collectionView.collectionViewLayout.invalidateLayout()
            
        }
        
    }
    
    
    
    
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)

        print(#function)
        
        // Code here will execute before the rotation begins.
        // Equivalent to placing it in the deprecated method -[willRotateToInterfaceOrientation:duration:]
    
        let indexPath = self.collectionView.indexPathsForVisibleItems[0]
        
        self.tempImageView.image = self.images[indexPath.row]
        self.tempImageView.isHidden = false
        self.collectionView.isHidden = true
        
        
        coordinator.animate(alongsideTransition: { (context) in
        
            print("will transition to alongside")

            if newCollection.verticalSizeClass == .regular {
                print("regular vertical")
            } else {
                print("compact vertical")
            }
            
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
            
        }) { (context) in

            // Code here will execute after the rotation has finished.
            // Equivalent to placing it in the deprecated method -[didRotateFromInterfaceOrientation:]
            
            
            self.collectionView.isHidden = false
            self.tempImageView.isHidden = true
            
        }
        
    }
    
    
    
    
    
//        override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//            super.viewWillTransition(to: size, with: coordinator)
//    
//            print(#function)
//            
//            coordinator.animate(alongsideTransition: { (context: UIViewControllerTransitionCoordinatorContext) in
//    
//    
//            }) { (context: UIViewControllerTransitionCoordinatorContext) in
//                
//
//                
//            }
//            
//        }
    
}






extension MainController: UICollectionViewDataSource {

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        return self.images.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.reuseIdentifer, for: indexPath) as! ImageCell
        
        let image: UIImage = images[indexPath.row]
        
        cell.imageView.image = image
        
        return cell
        
    }

}




extension MainController: UICollectionViewDelegateFlowLayout {


//    func collectionView(_ collectionView: UICollectionView, targetContentOffsetForProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
//    
//        let page = ceil(proposedContentOffset.x / self.collectionView.frame.size.width)
//        return CGPoint(x: page * (collectionView.bounds.size.width, y: 0)
//        
//    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return collectionView.frame.size
    
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0.0
    
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
       
        return 0.0
    
    }
    
}
