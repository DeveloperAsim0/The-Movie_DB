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
    
    var backgroundImage  = String()
    var posterImage_Path = String()
    var titleLabel       = String()
    var movieOverView    = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
