//
//  DetailViewController.swift
//  PhotoFlickr_Demo
//
//  Created by Sarath on 27/05/17.
//  Copyright © 2017 Xcoder. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var selectedItem: ImageTable?
    
    @IBOutlet weak var lastUpdatedDateLabelOutlet: UILabel!
    @IBOutlet weak var dislikeButtonAction: UIButton!
    @IBAction func likeButtonAction(_ sender: Any) {
        
        selectedItem?.lk = (selectedItem?.lk)! + 1;
        DBHandlerClass.shared.updateImageTableData(data: selectedItem!)
        if let lkcount = selectedItem?.lk {
            self.likeButtonOutlet.setTitle("LIKE(\(String( describing: lkcount)))BUTTON", for: .normal)
            
        }
        
    }
    @IBAction func DislikeButtonAction(_ sender: Any) {
        selectedItem?.dislike = (selectedItem?.dislike)! + 1;
        DBHandlerClass.shared.updateImageTableData(data: selectedItem!)
        if let dlkcount = selectedItem?.dislike {
        self.dislikeButtonOutlet.setTitle("DISLIKE(\(String(describing:dlkcount)))BUTTON", for: .normal)
        }
        
    }
    @IBOutlet weak var dislikeButtonOutlet: UIButton!
    @IBOutlet weak var likeButtonOutlet: UIButton!
    @IBOutlet weak var SelectedImageOutlet: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let myString = formatter.string(from: Date())
        // convert your string to date
        let yourDate = formatter.date(from: myString)
        //then again set the date format whhich type of output you need
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        // again convert your date to string
        let myStringafd = formatter.string(from: yourDate!)
        selectedItem?.updated_at = myStringafd
        //
        
        self.likeButtonOutlet.titleLabel?.numberOfLines = 2
        self.dislikeButtonAction.titleLabel?.numberOfLines = 2
        
        if let image = selectedItem?.url{
            let imageUrl = URL(string: image)
            self.lastUpdatedDateLabelOutlet.text = selectedItem?.updated_at
            SelectedImageOutlet.sd_setImage(with: imageUrl)
        }
        
        if let dlkcount = selectedItem?.dislike {
            self.likeButtonOutlet.setTitle("DISLIKE(\(String( describing: dlkcount)))BUTTON", for: .normal)
        }

        if let lkcount = selectedItem?.lk {
            self.likeButtonOutlet.setTitle("LIKE(\(String( describing: lkcount)))BUTTON", for: .normal)
        }

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
