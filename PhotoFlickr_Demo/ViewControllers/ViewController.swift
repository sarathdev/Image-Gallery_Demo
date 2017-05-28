//
//  ViewController.swift
//  PhotoFlickr_Demo
//
//  Created by Sarath on 27/05/17.
//  Copyright © 2017 Xcoder. All rights reserved.
//

import UIKit
import SDWebImage


class ViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    var selectedItem: ImageTable?
    var imagesArray : NSMutableArray! = NSMutableArray()
    @IBOutlet weak var collectionViewOutlet: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewOutlet.register(UINib(nibName: "PhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCollectionViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let dbHandler = DBHandlerClass.shared
        imagesArray.removeAllObjects()
        imagesArray.setArray(dbHandler.getImageTableData() as! [ImageTable])
        self.collectionViewOutlet.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: PhotoCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
        //      cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        let model : ImageTable = imagesArray[indexPath.row] as! ImageTable
        
        
        if let url = model.url{
            let imageUrl = URL(string:url)
            
            
            //        collectionView.sd_setShowActivityIndicatorView(true)
            //        collectionView.sd_setIndicatorStyle(.Gray)
            
            cell.backgroundImageOutlet.sd_setImage(with: imageUrl)
            
        }
        //        cell.backgroundImageOutlet.image = imagesArray[indexPath.row];
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        let ImgSize : CGSize = CGSize(width:(screenWidth/2)-15, height:(screenHeight/4)) //= originalImage.size
        return ImgSize;
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let model : ImageTable = imagesArray[indexPath.row] as! ImageTable
        self.selectedItem = model
        self.selectedItem?.click = (self.selectedItem?.click)! + 1
        DBHandlerClass.shared.updateImageTableData(data: selectedItem!)
        
        performSegue(withIdentifier: "detailpagesegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailpagesegue"{
            let viewcontroller = segue.destination as! DetailViewController
            viewcontroller.selectedItem = selectedItem
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesArray.count;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

