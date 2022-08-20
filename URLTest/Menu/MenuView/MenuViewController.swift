//
//  MenuViewController.swift
//  URLTest
//
//  Created by Adrian San Martin on 18/08/22.
//

import UIKit

import Firebase
import FirebaseAuth
class MenuViewController: UIViewController {

    var viewModel = MenuViewModel()
    var tvShow = TvShowVM()
    
    var email: String?
        
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var showOpction: UIBarButtonItem!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    private let myCellWidth = UIScreen.main.bounds.width / 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        segmentControl.tintColor = .white
        backButton.customView?.isHidden = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "MenuViewCell", bundle: nil), forCellWithReuseIdentifier: "myCell")
        
        configureView()
        bind()
        //configureViewTv()
        //bindTv()
    }
   
    
    @IBAction func showOptionAction(_ sender: Any) {
        let alert = UIAlertController(title: "", message: "What do you want to do", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "View Profile", style: .default, handler: { (action) in
            self.performSegue(withIdentifier: "ProfileSegue", sender: nil)
        }))
        alert.addAction(UIAlertAction(title: "Log out", style: .destructive, handler: { (action) in
            //try Auth.auth().signOut()
            self.navigationController?.popViewController(animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(alert, animated: true)
    }
    
    private func configureView(){
        viewModel.retriveDataList()
    }
    private func bind(){
        viewModel.refreshData = { [weak self] () in
            DispatchQueue.main.async{
                self?.collectionView.reloadData()
            }
        }
    }
    private func configureViewTv(){
        tvShow.retriveDataListTV()
    }
    private func bindTv(){
        tvShow.refreshDataTv = { [weak self] () in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
  
    // MARK: - Navigation
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let email = self.email
        let MenuSegue = segue.destination as! ProfileViewController
        MenuSegue.email = email
    }
    

}
extension MenuViewController: UICollectionViewDataSource{
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
            }catch{print("Error\(error.localizedDescription)") }
        }.resume()
      /*  let object = tvShow.dataListTv[indexPath.row]
        cell?.titleMovie.text = object.originalName
        cell?.dateMovie.text = object.firstAirDate
        cell?.rangeMovie.text = "⭐️\(object.voteAverage)"
        cell?.overMovie.text = object.overview
        //cell?.imagenPoster.image = UIImageView(image: <#T##UIImage?#>)
        */
        return cell!
    }
}

extension MenuViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var detailMovie = storyboard?.instantiateViewController(withIdentifier: "DetailMovieVC") as! DetailViewController
        detailMovie.detailMovie = viewModel.dataList[indexPath.row]
        detailMovie.imgPath = "\(viewModel.dataList[indexPath.row].posterPath)"
        self.navigationController?.pushViewController(detailMovie, animated: true)
    }
}
//Extension para accionar las acciones del boton
extension MenuViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: myCellWidth - 10.0 , height: 355.0)
    }
}
