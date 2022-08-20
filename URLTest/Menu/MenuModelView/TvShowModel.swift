//
//  TvShowModel.swift
//  URLTest
//
//  Created by Adrian San Martin on 19/08/22.
//

import Foundation

class TvShowModel {

var refreshData = { () -> () in }

var dataList: [TvShows] = [] {
    didSet { refreshData() }
}

func retriveDataList() {
    
    guard let url = URL(string: "https://api.themoviedb.org/3/tv/1418?api_key=6211d940adfd49ac181b6546b14ff89d&language=en-US") else { return }
      
URLSession.shared.dataTask(with: url) { (data, response, error) in
        
    guard let json = data else { return }
        do{
            let decoder = JSONDecoder()
            let result = try decoder.decode(TvShows.self, from: json)
            print(result)
            //self.dataList = result
        }catch let error {
            print("No hay respuesta: \(error.localizedDescription)")
        }
    }.resume()
}
}
