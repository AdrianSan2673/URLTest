//  MenuViewController.swift
//  URLTest
//
//  Created by Adrian San Martin on 18/08/22.

import UIKit

import Firebase
import FirebaseAuth
class MenuViewController: UIViewController {

    var viewModel = MenuViewModel()
    var tvShow = TvShowVM()
    var topMovie = TopMovieModel()
    var airingTv = AiringViewModel()
    
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
    }
    @IBAction func segmentControlAction(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            configureView()
            bind()
        } else if sender.selectedSegmentIndex == 1{
            topMovie.retriveDataListTopMovie()
            topMovie.refreshDataTopMovie = { [weak self] () in
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            }
        }else if sender.selectedSegmentIndex == 2{
            tvShow.retriveDataListTV()
            tvShow.refreshDataTv = { [weak self] () in
                DispatchQueue.main.async{
                    self?.collectionView.reloadData()
                }
            }
        }else if sender.selectedSegmentIndex == 3{
            airingTv.retriveDataListAiring()
            airingTv.refreshDataAiring = { [weak self] () in
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            }
        }
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
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let email = self.email
        let MenuSegue = segue.destination as! ProfileViewController
        MenuSegue.email = email
    }
}
extension MenuViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var value = 0
        switch segmentControl.selectedSegmentIndex{
        case 0:
            value = viewModel.dataList.count
            break
        case 1:
            value = topMovie.dataListTopMovie.count
            break
        case 2:
            value = tvShow.dataListTv.count
            break
        case 3:
            value = airingTv.dataListAiring.count
            break
        default:
            print("Error")
            break
        }
        return value
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as? MenuViewCell
        switch segmentControl.selectedSegmentIndex{
        case 0: //Popular
            let objectMovie = viewModel.dataList[indexPath.row]
            cell?.onBindMovies(data: objectMovie)
            break
        case 1: //Top Ranked
            let objectTopMovie = topMovie.dataListTopMovie[indexPath.row]
            cell?.onBindTopMovie(dataTop: objectTopMovie)
            break
        case 2: // On TV
            let objectTv = tvShow.dataListTv[indexPath.row]
            cell?.onBindTvShow(dataTv: objectTv)
            break
        case 3:// Airing TV
            let objectAiring = airingTv.dataListAiring[indexPath.row]
            cell?.onBindAiring(dataAiring: objectAiring)
        default:
            print("Error")
            break
        }
        return cell!
    }
}
extension MenuViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var detailMovie = storyboard?.instantiateViewController(withIdentifier: "DetailMovieVC") as! DetailViewController
        
        switch segmentControl.selectedSegmentIndex{
        case 0: //popular
            detailMovie.state = 0
            detailMovie.detailMovie = viewModel.dataList[indexPath.row]
            detailMovie.imgPath = "\(viewModel.dataList[indexPath.row].posterPath)"
            break
        case 1:
            detailMovie.state = 1
            detailMovie.detailTopMovie = topMovie.dataListTopMovie[indexPath.row]
            detailMovie.imgPath = "\(topMovie.dataListTopMovie[indexPath.row].posterPath)"
            break
        case 2:
            detailMovie.state = 2
            detailMovie.detailTv = tvShow.dataListTv[indexPath.row]
            detailMovie.imgPath = "\(tvShow.dataListTv[indexPath.row].posterPath)"
            break
        case 3:
            detailMovie.state = 3
            detailMovie.detailTv = airingTv.dataListAiring[indexPath.row]
            detailMovie.imgPath = "\(airingTv.dataListAiring[indexPath.row].posterPath)"
            break
        default:
            print("Error")
            break
        }
        self.navigationController?.pushViewController(detailMovie, animated: true)
    }
}
//Extension para accionar las acciones del boton
extension MenuViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: myCellWidth - 10.0 , height: 355.0)
    }
}
