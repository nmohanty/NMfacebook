//
//  BoxTransition.swift
//  Facebook
//
//  Created by Namrata Mohanty on 11/13/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class BoxTransition: BaseTransition {
    
    var originalselectedIVFrame: CGRect!
    var originalphotoIVFrame: CGRect!
    
    
    var blackView: UIView!
    
    
    override func presentTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        
        
        let tabViewController = fromViewController as! UITabBarController
        let navigationController = tabViewController.selectedViewController as! UINavigationController
        let feedViewController = navigationController.topViewController as! NewsFeedViewController
               let newphotoViewController = toViewController as! PhotoViewController

        
        
        
        let selectedImageView = feedViewController.imageView
        let newphotoImageView = newphotoViewController.imageView
        
        
        originalselectedIVFrame = selectedImageView!.frame.offsetBy(dx: 0, dy: 126)
        selectedImageView!.isHidden = true
        blackView = UIView(frame: newphotoViewController.view.frame)
        blackView.backgroundColor = UIColor.black
        blackView.alpha = 0
        containerView.addSubview(blackView)
        
        let movingImage = UIImageView(frame: originalselectedIVFrame)
        movingImage.contentMode = UIViewContentMode.scaleAspectFill
        movingImage.clipsToBounds = selectedImageView!.clipsToBounds
        movingImage.image =  selectedImageView!.image
        let window = UIApplication.shared.keyWindow
        window?.addSubview(movingImage)
        
        containerView.addSubview((newphotoViewController.view)!)
        newphotoViewController.view.alpha = 0
        
        UIView.animate(withDuration: duration, animations: {
            newphotoViewController.imageView.isHidden = true
            newphotoViewController.view.alpha = 1
            self.blackView.alpha = 1
            
            movingImage.frame = newphotoViewController.imageView.frame.offsetBy(dx: 0, dy: 52)
            movingImage.contentMode = UIViewContentMode.scaleAspectFit
            
            
        }) { (finished: Bool) -> Void in
            movingImage.contentMode = (newphotoImageView?.contentMode)!
             movingImage.clipsToBounds = newphotoImageView!.clipsToBounds
             movingImage.removeFromSuperview()
            self.blackView.removeFromSuperview()
            newphotoViewController.imageView.isHidden = false
            selectedImageView?.isHidden = false
            self.finish()
        }
        
        
        
    }
    
    override func dismissTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        
        let tabViewController = toViewController as! UITabBarController
        let navigationController = tabViewController.selectedViewController as! UINavigationController
        let feedViewController = navigationController.topViewController as! NewsFeedViewController
        let newphotoViewController = fromViewController as! PhotoViewController
        
        
        let selectedImageView = feedViewController.imageView
        let newphotoImageView = newphotoViewController.imageView
        
        originalphotoIVFrame = newphotoImageView!.frame.offsetBy(dx: 0, dy: 42)
       selectedImageView!.isHidden = true
        let movingImage = UIImageView(frame: originalphotoIVFrame)
        movingImage.contentMode = UIViewContentMode.scaleAspectFill
        movingImage.clipsToBounds = selectedImageView!.clipsToBounds
        movingImage.image =  newphotoImageView!.image
        let window = UIApplication.shared.keyWindow
        window?.addSubview(movingImage)
        
        
        blackView = UIView(frame: newphotoViewController.view.frame)
        blackView.backgroundColor = UIColor.black
        blackView.alpha = 0
        containerView.addSubview(blackView)
        self.blackView.alpha = 0.6
        UIView.animate(withDuration: duration, animations: {
            newphotoImageView?.isHidden = true
            self.blackView.alpha = 0
            
            
            movingImage.frame = selectedImageView!.frame.offsetBy(dx: 0, dy: 126)
            movingImage.contentMode = (newphotoImageView?.contentMode)!
            
            
        }) { (finished: Bool) -> Void in
            movingImage.contentMode = (newphotoImageView?.contentMode)!
            movingImage.clipsToBounds = newphotoImageView!.clipsToBounds
            movingImage.removeFromSuperview()
            self.blackView.removeFromSuperview()
            selectedImageView?.isHidden = false
            self.finish()
        }
        
        
        
        
        
}


}
   /* var originalphotoIVFrame: CGRect!
    var originalfeedIVFrame: CGRect!
    var blackView: UIView!
    
    override func presentTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        
        let tabViewController = fromViewController as! UITabBarController
        let navigationController = tabViewController.selectedViewController as! UINavigationController
        let feedViewController = navigationController.topViewController as! NewsFeedViewController
        // let newsFeedViewController = fromViewController as! NewsFeedViewController
        let toViewController = toViewController as! PhotoViewController
        
        let selectedImageView = feedViewController.imageView
        let photoImageView = toViewController.imageView
        
        //originalphotoIVFrame = photoImageView!.frame
        originalfeedIVFrame = selectedImageView!.frame.offsetBy(dx: 0, dy: 126)
        
        photoImageView!.frame = selectedImageView!.frame
        // photoImageView!.frame.size.height =
        
        selectedImageView!.isHidden = true
        
        // creating window
        
        let window = UIApplication.shared.keyWindow
        let movingImage = UIImageView()
        /*if #available(iOS 8.0, *) {
         movingImage.frame = movingImage.convert(selectedImageView!.frame, to: containerView)
         } else {
         // Fallback on earlier versions
         }*/
        movingImage.frame = originalfeedIVFrame
        movingImage.contentMode = UIViewContentMode.scaleAspectFill
        movingImage.clipsToBounds = selectedImageView!.clipsToBounds
        movingImage.image =  selectedImageView!.image
        
        window?.addSubview(movingImage)
        //containerView.addSubview(movingImage)
        
        //creating lightbox
        //containerView.backgroundColor = UIColor(white: 0, alpha: 0.3)
        
        blackView = UIView()
        blackView.frame = containerView.bounds
        blackView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        blackView.alpha = 0
        containerView.addSubview(blackView)
        
        containerView.addSubview(toViewController.view)
        toViewController.view.alpha = 0
        
        UIView.animate(withDuration: duration, animations: {
            self.blackView.alpha = 1
            toViewController.imageView.isHidden = true
            toViewController.view.alpha = 1
            if #available(iOS 8.0, *) {
                movingImage.frame = movingImage.convert(selectedImageView!.frame, to: containerView)
            } else {
                // Fallback on earlier versions
            }
            
            //movingImage.frame = photoViewController.imageView.frame.offsetBy(dx: 0, dy: 42)
            movingImage.contentMode = UIViewContentMode.scaleAspectFit
            
            
        }) { (finished: Bool) -> Void in
            movingImage.contentMode = (photoImageView?.contentMode)!
            movingImage.clipsToBounds = photoImageView!.clipsToBounds
            
            movingImage.removeFromSuperview()
            self.blackView.removeFromSuperview()
            toViewController.imageView.isHidden = false
            selectedImageView?.isHidden = false
            self.finish()
        }
    }
    
    override func dismissTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        
        //let tabViewController = fromViewController as! UITabBarController
        let navigationController = tabViewController.selectedViewController as! UINavigationController
        let feedViewController = navigationController.topViewController as! NewsFeedViewController
        let toViewController = toViewController as! PhotoViewController
        
        let selectedImageView = feedViewController.imageView
        let photoImageView = toViewController.imageView
        
        originalphotoIVFrame = photoImageView!.frame.offsetBy(dx: 0, dy: 42)
        
        selectedImageView!.isHidden = true
        
        // creating window
        
        let window = UIApplication.shared.keyWindow
        //let movingImage = UIImageView()
        let movingImage = UIImageView(frame: originalphotoIVFrame)
        /*if #available(iOS 8.0, *) {
         movingImage.frame = movingImage.convert(photoImageView!.frame, to: containerView)
         } else {
         // Fallback on earlier versions
         }*/
        movingImage.contentMode = UIViewContentMode.scaleAspectFill
        movingImage.clipsToBounds = selectedImageView!.clipsToBounds
        movingImage.image =  photoImageView!.image
        
        window?.addSubview(movingImage)
        //containerView.addSubview(movingImage)
        
        
        
        //blackView = UIView()
        //blackView.frame = containerView.bounds
        blackView = UIView(frame: photoImageView!.frame)
        blackView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        blackView.alpha = 0.7
        containerView.addSubview(blackView)
        
        //toViewController.view.alpha = 0
        
        //fromViewController.view.alpha = 0
        
        UIView.animate(withDuration: duration, animations: {
            photoImageView?.isHidden = true
            self.blackView.alpha = 0
            
            
            movingImage.frame = selectedImageView!.frame.offsetBy(dx: 0, dy: 126)
            movingImage.contentMode = (photoImageView?.contentMode)!
        }) { (finished: Bool) -> Void in
            movingImage.contentMode = (photoImageView?.contentMode)!
            movingImage.clipsToBounds = photoImageView!.clipsToBounds
            
            movingImage.removeFromSuperview()
            self.blackView.removeFromSuperview()
            
            toViewController.imageView.isHidden = false
            selectedImageView?.isHidden = false
            
            self.finish()
            
        }
    }
    
    
}*/
