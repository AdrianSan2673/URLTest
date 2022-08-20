//
//  ProfileViewController.swift
//  URLTest
//
//  Created by Adrian San Martin on 19/08/22.
//

import UIKit

class ProfileViewController: UIViewController {

    var viewModel = MenuViewModel()
    
    var email: String?
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileCollection: UICollectionView!
    @IBOutlet weak var profileUsername: UILabel!
    private let myCellWidth = UIScreen.main.bounds.width / 2
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let username = email else {return}
        profileUsername.text = username
        profileCollection.dataSource = self
        profileCollection.delegate = self
        profileCollection.register(UINib(nibName: "MenuViewCell", bundle: nil), forCellWithReuseIdentifier: "myCell")
        profileImage.image = UIImage(named: "profile")
        configureView()
        bind()
    }
    

    private func configureView(){
        viewModel.retriveDataList()
    }
    private func bind(){
        viewModel.refreshData = { [weak self] () in
            DispatchQueue.main.async{
                self?.profileCollection.reloadData()
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

extension ProfileViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.dataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as? MenuViewCell
        let object = viewModel.dataList[indexPath.row]
        cell!.titleMovie.text = object.title
        cell!.dateMovie.text = object.releaseDate
        cell!.rangeMovie.text = "⭐️\(String(object.voteAverage))"
        cell!.overMovie.text = object.overview
       URLSession.shared.dataTask(with: URLRequest(url: URL(string: "https://image.tmdb.org/t/p/w342/\(object.posterPath)")!)){
            (data, req, error) in
            do{
                let dataIm = try data
                DispatchQueue.main.async {
                cell?.imagenPoster.image = UIImage(data: dataIm!)
                }
            }catch{print("Error\(error.localizedDescription)")}
        }.resume()
        return cell!
    }
}

extension ProfileViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var detailMovie = storyboard?.instantiateViewController(withIdentifier: "DetailMovieVC") as! DetailViewController
        detailMovie.detailMovie = viewModel.dataList[indexPath.row]
        detailMovie.imgPath = "\(viewModel.dataList[indexPath.row].posterPath)"
        self.navigationController?.pushViewController(detailMovie, animated: true)
    }
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: myCellWidth - 10.0 , height: 355.0)
    }
}
