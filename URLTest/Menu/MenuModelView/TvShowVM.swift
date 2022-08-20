//
//  TvShowVM.swift
//  URLTest
//
//  Created by Adrian San Martin on 19/08/22.
//

import Foundation


class TvShowVM{
    var refreshDataTv = { () -> () in }
    
    var dataListTv: [TVShow] = [] {
        didSet { refreshDataTv() }
    }
    
    func retriveDataListTV() {
         guard let url = URL(string: "https://api.themoviedb.org/3/tv/1418?api_key=6211d940adfd49ac181b6546b14ff89d&language=en-US") else { return }
          
    URLSession.shared.dataTask(with: url) { (data, response, error) in
            
        guard let json = data else { return }
            do{
                let decoder = JSONDecoder()
                 let result = try decoder.decode([TVShow].self, from: json)
                //self.dataListTv
            }catch let error {
                print("No hay respuesta TVSHOW: \(error.localizedDescription)")
            }
        }.resume()
    }
}
