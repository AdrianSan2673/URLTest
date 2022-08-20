//
//  ViewController.swift
//  URLTest
//
//  Created by Adrian San Martin on 18/08/22.
//

import UIKit

class ViewController: UIViewController {
    
   
    
    @IBOutlet weak var tableView: UITableView!
    var dataList = [Result]()
    
    override func viewDidLoad() {
     /*   super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
       
       guard let url = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=c7f7d1dc5a6aa58fd2f3602748ad9c64&language=en-US&page=1") else {return}
        let session = URLSession.shared.dataTask(with: url){
            (data, req, error) in
            do{
                let result = try JSONDecoder().decode(Movie.self, from: data!)
                DispatchQueue.main.async {
                    print("the response: \(result.results)")
                    self.dataList = result.results
                    self.tableView.reloadData()
                }
            }catch{
                print("No hay respuesta\(error.localizedDescription)")
            }
        }.resume()*/
    }
}
extension ViewController : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        //cell.onBind(data: dataList[indexPath.row])
        return cell
    }
}
