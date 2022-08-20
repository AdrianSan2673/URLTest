//
//  MenuViewModel.swift
//  URLTest
//
//  Created by Adrian San Martin on 18/08/22.
//

import Foundation

class MenuViewModel {
    //Crear un Mecanismo para enlazar lo que seria la vista con este Model de la vista
    var refreshData = { () -> () in }
    //Fuente de datos (Array)
    var dataList: [Result] = [] {
        didSet { refreshData() }
    }
    //Obtener los datos de la API
    func retriveDataList() {
        //guard let url = URL(string: "https://api.themoviedb.org/3/certification/movie/list?api_key=6211d940adfd49ac181b6546b14ff89d") else {return}
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=6211d940adfd49ac181b6546b14ff89d&language=en-US&page=1") else { return }
          
    URLSession.shared.dataTask(with: url) { (data, response, error) in
            
        guard let json = data else { return }
            do{
                let decoder = JSONDecoder()
                let result = try decoder.decode(Movie.self, from: json)
                self.dataList = result.results
            }catch let error {
                print("No hay respuesta: \(error.localizedDescription)")
            }
        }.resume()
    }
}
