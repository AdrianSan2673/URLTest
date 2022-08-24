//
//  MenuViewCell.swift
//  URLTest
//
//  Created by Adrian San Martin on 18/08/22.
//

import UIKit

class MenuViewCell: UICollectionViewCell {

    var viewModel = MenuViewModel()
    var viewModelTv = TvShowVM()
    var viewModelTop = TopMovieModel()
    var viewModelAiring = AiringViewModel()
    
    @IBOutlet weak var imagenPoster: UIImageView!
    @IBOutlet weak var titleMovie: UILabel!
    @IBOutlet weak var dateMovie: UILabel!
    @IBOutlet weak var rangeMovie: UILabel!
    @IBOutlet weak var overMovie: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
  
    }
    //Peliculas
    func configureView(){ viewModel.retriveDataList()}
    func onBindMovies(data: Result){
        titleMovie.text = data.title
        dateMovie.text = data.releaseDate
        rangeMovie.text = "⭐️\(String(data.voteAverage))"
        overMovie.text = data.overview
        URLSession.shared.dataTask(with: URLRequest(url: URL(string: "https://image.tmdb.org/t/p/w342/\(data.posterPath)")!)){
             (data, req, error) in
             do{
                 let dataIm = try data
                 DispatchQueue.main.async {
                     self.imagenPoster.image = UIImage(data: dataIm!)
                 }
             }catch{print("Error\(error.localizedDescription)") }
         }.resume()
    }
    //TOP VIEW
    func configureViewTop(){ viewModelTop.retriveDataListTopMovie() }
    func onBindTopMovie(dataTop: ResultTopMovie){
        titleMovie.text = dataTop.title
        dateMovie.text = dataTop.originalLanguage
        rangeMovie.text = "⭐️\(String(dataTop.voteAverage))"
        overMovie.text = dataTop.overview
        URLSession.shared.dataTask(with: URLRequest(url: URL(string: "https://image.tmdb.org/t/p/w342/\(dataTop.posterPath)")!)){
             (data, req, error) in
             do{
                 let dataIm = try data
                 DispatchQueue.main.async {
                     self.imagenPoster.image = UIImage(data: dataIm!)
                 }
             }catch{print("Error\(error.localizedDescription)") }
         }.resume()
    }
    //TV ON
    func configureViewTvShow(){ viewModelTv.retriveDataListTV() }
    func onBindTvShow(dataTv: ResultTv){
        titleMovie.text = dataTv.originalName
        dateMovie.text = dataTv.firstAirDate
        rangeMovie.text = "⭐️\(String(dataTv.voteAverage))"
        overMovie.text = dataTv.overview
        URLSession.shared.dataTask(with: URLRequest(url: URL(string: "https://image.tmdb.org/t/p/w342/\(dataTv.posterPath)")!)){
             (data, req, error) in
             do{
                 let dataIm = try data
                 DispatchQueue.main.async {
                     self.imagenPoster.image = UIImage(data: dataIm!)
                 }
             }catch{print("Error\(error.localizedDescription)") }
         }.resume()
    }
    //Airing TV
    func configureViewAiring(){viewModelAiring.retriveDataListAiring()}
    func onBindAiring(dataAiring: ResultTv){
        titleMovie.text = dataAiring.originalName
        dateMovie.text = dataAiring.firstAirDate
        rangeMovie.text = "⭐️\(String(dataAiring.voteAverage))"
        overMovie.text = dataAiring.overview
        URLSession.shared.dataTask(with: URLRequest(url: URL(string: "https://image.tmdb.org/t/p/w342/\(dataAiring.posterPath)")!)){
             (data, req, error) in
             do{
                 let dataIm = try data
                 DispatchQueue.main.async {
                     self.imagenPoster.image = UIImage(data: dataIm!)
                 }
             }catch{print("Error\(error.localizedDescription)") }
         }.resume()
    }
    
    
}
