//
//  PhotoViewController.swift
//  Facebook
//
//  Created by Namrata Mohanty on 11/11/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UIScrollViewDelegate {

    var image: UIImage!
    //var newcontainerView: UIView!
    //var translationY: CGFloat!
    var originalImageCenter: CGFloat!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var actionsButtonImage: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var blackBox: UIView!
    
    var photo_1: UIImage!
    var photo_2: UIImage!
    var photo_3: UIImage!
    var photo_4: UIImage!
    var photo_5: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        blackBox.alpha = 0

        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: 1280, height: 600)
         imageView.image = image
        scrollView.frame.size = CGSize(width: 320, height: 525)

        
        originalImageCenter = view.center.x
        imageView.center.x = originalImageCenter
        
        photo_1 = UIImage(named: "wedding1")
        photo_2 = UIImage(named: "wedding2")
        photo_3 = UIImage(named: "wedding3")
        photo_4 = UIImage(named: "wedding4")
        photo_5 = UIImage(named: "wedding5")
        
        pageControl.currentPage = 0
        
           }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // This method is called as the user scrolls
        
        if scrollView.contentOffset.y > 0 &&  scrollView.contentOffset.y < 100 {
            blackBox.alpha = 0
            scrollView.alpha = convertValue(inputValue: scrollView.contentOffset.y, r1Min: 0, r1Max: 100, r2Min: 1, r2Max: 0.4)
            
            actionsButtonImage.alpha = convertValue(inputValue: scrollView.contentOffset.y, r1Min: 0, r1Max: 100, r2Min: 1, r2Max: 0)
          
            doneButton.alpha = convertValue(inputValue: scrollView.contentOffset.y, r1Min: 0, r1Max: 100, r2Min: 1, r2Max: 0)
            

            
        } else {
            blackBox.alpha = 0
            scrollView.alpha = convertValue(inputValue: scrollView.contentOffset.y, r1Min: 0, r1Max: -100, r2Min: 1, r2Max: 0.4)

            actionsButtonImage.alpha = convertValue(inputValue: scrollView.contentOffset.y, r1Min: 0, r1Max: -100, r2Min: 1, r2Max: 0)
     
            doneButton.alpha = convertValue(inputValue: scrollView.contentOffset.y, r1Min: 0, r1Max: -100, r2Min: 1, r2Max: 0)
        
    }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
       // let originalmovingimageY = imageView.center.y
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        // This method is called right as the user lifts their finger
        if scrollView.contentOffset.y < -100 {
          
          blackBox.isHidden = true
            doneButton.isHidden = true
            actionsButtonImage.isHidden = true
            UIView.animate(withDuration: 0.4, animations: {
                
                self.dismiss(animated: true, completion: nil)
            })
            
        } else if scrollView.contentOffset.y > 100 {
            print("dismiss on scroll")
            blackBox.isHidden = true
            doneButton.isHidden = true
            actionsButtonImage.isHidden = true
            UIView.animate(withDuration: 0.4, animations: {
                
                self.dismiss(animated: true, completion: nil)
                
            })
        }
        
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // This method is called when the scrollview finally stops scrolling.
        UIView.animate(withDuration: 0.3, animations: {
            self.doneButton.alpha = 1
            self.actionsButtonImage.alpha = 1
        })
        let page: Int = Int(round(scrollView.contentOffset.x / 320))
        pageControl.currentPage = page
        if page == 0 {
            imageView.image = photo_1
            imageView.center.x = originalImageCenter
        }
        else if page == 1 {
            imageView.image = photo_2
            imageView.center.x = originalImageCenter * 3
        }
        else if page == 2 {
            imageView.image = photo_3
            imageView.center.x = originalImageCenter * 5
        }
        else if page == 3 {
            imageView.image = photo_4
            imageView.center.x = originalImageCenter * 7
        }
        else if page == 4{
            imageView.image = photo_5
            imageView.center.x = originalImageCenter * 9
        }
        

    }// enddecelerate
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
                return imageView
    }

    @IBAction func didTapDone(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
   
    

    
      override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
