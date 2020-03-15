//
//  DetailViewController.swift
//  The Movie_DB
//
//  Created by Mihir Vyas on 14/03/20.
//  Copyright © 2020 Mihir Vyas. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import SDWebImage

class DetailViewController: UIViewController {

    @IBOutlet weak var PosterImagePost: UIImageView!
    @IBOutlet weak var smallposterImage: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var overView: UILabel!
    @IBOutlet weak var videoView: UIWebView!
    
    
    var backgroundImage  = String()
    var posterImage_Path = String()
    var titleLabel       = String()
    var movieOverView    = String()
    var movieID          = String()
    var movie_KEY        = String()
    
    let MovieIDURL = "https://api.themoviedb.org/3/movie/122/videos?api_key=a8c5ff4de917550ea17a57bc73590a66&language=en-US"
    
    override func viewDidLoad() {
        super.viewDidLoad()
      fetch_movie_ID()
    }
    
    func fetch_movie_ID(){
        request("https://api.themoviedb.org/3/movie/\(self.movieID)/videos?api_key=a8c5ff4de917550ea17a57bc73590a66&language=en-US").responseJSON { (myResponse) in
            switch myResponse.result {
            case .success:
                print(myResponse.result)
                let myresult = try? JSON(data: myResponse.data!)
                print(myresult!["results"])
                let resultArray = myresult!["results"]
                self.movie_KEY.removeAll()
                for i in resultArray.arrayValue {
                    let movieKeyID = i["key"].stringValue
                    self.movie_KEY.append(movieKeyID)
                    print("movieID:- \(self.movie_KEY)")
                }
                break
                
            case .failure:
                print(Error.self)
                break
            }
        }
    }
    
    func getVideos() {
        let url = URL(string: "https://www.youtube.com/watch?v=\(self.movie_KEY)")
        print("myurl:- \(url)")
           videoView.loadRequest(URLRequest(url: url!))
       }
       
    
    @IBAction func videoplay(_ sender: Any) {
        self.videoView.isHidden = false
        getVideos()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.movieName.text = titleLabel
        self.overView.text  = movieOverView
        DispatchQueue.global().async {
        let imageurl = NSURL(string: self.backgroundImage)
        let imagedata = NSData(contentsOf: imageurl! as URL )
        
        let imageurl2 = NSURL(string: self.posterImage_Path)
        let imagedata2 = NSData(contentsOf: imageurl2! as URL )
            
        if (imagedata != nil && imagedata2 != nil) {
             DispatchQueue.main.async {
            self.PosterImagePost.image  = UIImage(data: imagedata! as Data)
            self.smallposterImage.image = UIImage(data: imagedata2! as Data)
           
            }
        }
            
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
