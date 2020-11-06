//
//  ViewController.swift
//  PortfolioRedondo
//
//  Created by Akhelys Redondo on 10/7/20.
//  Copyright © 2020 Akhelys Redondo. All rights reserved.
//

import UIKit
import ZKCarousel

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    //MARK: - Declaration of variables
    var indexstr = ""
    var indexctr = 0
    let strimages = ["Card Game", "Bitcoin Tracker","Xylophone Soundboard","Weather App", "Core Data","Firebase"]
    let displayImages : [UIImage] = [
        UIImage(named:"cardGame")!,
        UIImage(named:"bitcoinLogo")!,
        UIImage(named:"xyloLogo")!,
        UIImage(named:"WeatherLogo")!,
        UIImage(named:"CoredataLogo")!,
        UIImage(named:"FirebaseLogo")!,

    ]
    
    // Carousel declaration and initiation
    @IBOutlet weak var carousel: ZKCarousel!
    private func setupCarousel() {
        
        //Create carousel slides
        let slide1 = ZKCarouselSlide(image: UIImage(named: "banner8f")!,
                                     title: "",
                                     description: "")
        let slide2 = ZKCarouselSlide(image: UIImage(named: "banner3f")!,
                                     title: "",
                                     description: "")
        let slide3 = ZKCarouselSlide(image: UIImage(named: "banner4f")!,
                                     title: "",
                                     description: "")
        let slide4 = ZKCarouselSlide(image: UIImage(named: "banner5f")!,
                                     title: "",
                                     description: "")
        let slide5 = ZKCarouselSlide(image: UIImage(named: "banner6f")!,
                                     title: "",
                                     description: "")
        let slide6 = ZKCarouselSlide(image: UIImage(named: "banner7f")!,
                                     title: "",
                                     description: "")
        let slide7 = ZKCarouselSlide(image: UIImage(named: "banner2f")!,
                                     title: "",
                                     description: "")

       
        // Add the slides to the carousel
        self.carousel.slides = [slide1, slide2, slide3, slide4, slide5, slide6 , slide7]
        self.carousel.interval = 8
        self.carousel.start()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         setupCarousel()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Collection View Delegates and data source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return strimages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        
        // Cell Formatting
        cell.myLabel.text = strimages[indexPath.item]
        cell.myImageDisplay.image = displayImages[indexPath.item]
        
        cell.contentView.layer.cornerRadius = 5.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = true
        
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        cell.layer.shadowRadius = 2.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //Performing Segue Main Directory
        indexctr = indexPath.item
        indexstr = strimages[indexPath.item]
      
        if strimages[indexPath.item] == "Card Game"{
            performSegue(withIdentifier: "mainToCardSegue", sender: self)
        }
        if strimages[indexPath.item] == "Xylophone Soundboard"{
            performSegue(withIdentifier: "mainToXyloSegue", sender: self)
        }
        if strimages[indexPath.item] == "Firebase"{
            performSegue(withIdentifier: "mainToFirebaseSegue", sender: self)
        }
        if strimages[indexPath.item] == "Core Data"{
            performSegue(withIdentifier: "mainToCDViewController", sender: self)
        }
        if strimages[indexPath.item] == "Weather App"{
            performSegue(withIdentifier: "mainToWeatherSegue", sender: self)
        }
        if strimages[indexPath.item] == "Bitcoin Tracker"{
            performSegue(withIdentifier: "mainToBitcoinSegue", sender: self)
        }
    }
    
    //MARK: Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        if segue.identifier == "mainToXyloSegue" {
            _ = segue.destination as! XylophoneViewController
            
        }
        if segue.identifier == "mainToCardSegue" {
            _ = segue.destination as! CardGameViewController
            
        }
        
        if segue.identifier == "mainToFirebaseSegue" {
            _ = segue.destination as! FirebaseViewController
            
        }
        
        if segue.identifier == "mainToCDViewController" {
            _ = segue.destination as! CDTableViewController
            
        }
        
        if segue.identifier == "mainToWeatherSegue" {
            _ = segue.destination as! WeatherViewController
            
        }
        
        if segue.identifier == "mainToBitcoinSegue" {
            _ = segue.destination as! BitcoinViewController
            
        }
      
    }
    
  
}

