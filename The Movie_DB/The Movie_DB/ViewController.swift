//
//  ViewController.swift
//  The Movie_DB
//
//  Created by Tarun Meena on 13/03/20.
//  Copyright © 2020 Mihir Vyas. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
import SwiftyJSON

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collection: UICollectionView!
    var API_URL = "https://api.themoviedb.org/3/movie/upcoming?api_key=a8c5ff4de917550ea17a57bc73590a66&language=en-US&page=1"
    
    var poster_path_URL = "https://image.tmdb.org/t/p/w185/"
    
    var posterImages   = [String]()
    var poster_ID      = [String]()
    var backdrop_Path  = [String]()
    var image_Title    = [String]()
    var movie_Overview = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collection.dataSource = self
        collection.delegate = self
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        
        get_Api_Data()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    func get_Api_Data() {
        request(self.API_URL).responseJSON { (myResponse) in
            switch myResponse.result {
            case .success:
                print(myResponse.result)
                let myresult = try? JSON(data: myResponse.data!)
                print(myresult!["results"])
                let resultArray = myresult!["results"]
                self.posterImages.removeAll()
                self.backdrop_Path.removeAll()
                for i in resultArray.arrayValue {
                    let posterID = i["id"].stringValue
                    self.poster_ID.append(posterID)
                    print("idpos:- \(self.poster_ID)")
                    let posterImage = self.poster_path_URL + i["poster_path"].stringValue
                    self.posterImages.append(posterImage)
                    print("poster images:- \(self.posterImages)")
                    let backdropPath = self.poster_path_URL + i["backdrop_path"].stringValue
                    self.backdrop_Path.append(backdropPath)
                    print("backdropPath:- \(self.backdrop_Path)")
                    let imageTitle = i["title"].stringValue
                    self.image_Title.append(imageTitle)
                    let movieoverview = i["overview"].stringValue
                    self.movie_Overview.append(movieoverview)
                }
                self.collection.reloadData()
                break
                
            case .failure:
                print(Error.self)
                break
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
//        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
//        let size:CGFloat = (collection.frame.size.width - space) / 2.0
        return CGSize(width: (view.frame.width / 2) - 13, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
       let controller = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        
        controller?.backgroundImage = backdrop_Path[indexPath.row] 
        controller?.posterImage_Path = posterImages[indexPath.row]
        controller?.titleLabel = image_Title[indexPath.row]
        controller?.movieOverView = movie_Overview[indexPath.row]
        controller?.movieID = poster_ID[indexPath.row]
        controller?.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller!, animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return poster_ID.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "testcell", for: indexPath) as! CollectionViewCell
        cell.backgroundColor = UIColor.black
        cell.posterImage.sd_setImage(with: URL(string: posterImages[indexPath.row]), placeholderImage: UIImage(named: "city-of-gold-coast-o5TTYcAlbHc-unsplash"))
        print(cell.posterImage)
        return cell
    }
    
    

}

