//
//  DetailViewController.swift
//  URLTest
//
//  Created by Adrian San Martin on 19/08/22.
//

import UIKit

class DetailViewController: UIViewController {

    var detailMovie: Result?
    var imgPath: String?
    
    @IBOutlet weak var detailImg: UIImageView!
    @IBOutlet weak var nameMovie: UILabel!
    @IBOutlet weak var releaseMovie: UILabel!
    @IBOutlet weak var voteMovie: UILabel!
    @IBOutlet weak var overvMovie: UILabel!
    
    @IBOutlet weak var categoryMovie: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        imgPath = "https://image.tmdb.org/t/p/w342/\(imgPath!)"
        guard let vote = detailMovie?.voteAverage else {return}
        nameMovie.text = detailMovie?.title
        releaseMovie.text = detailMovie?.releaseDate
        voteMovie.text = "⭐️\(vote)"
        overvMovie.text = "Language\(detailMovie?.originalLanguage)"
        categoryMovie.text = detailMovie?.overview
        URLSession.shared.dataTask(with: URLRequest(url: URL(string: imgPath!)!)) { (data, req, error) in
            do {
                let dataImg = try data
                DispatchQueue.main.async {
                    self.detailImg.image = UIImage(data: dataImg!)
                }
            } catch{}
        }.resume()
        
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
