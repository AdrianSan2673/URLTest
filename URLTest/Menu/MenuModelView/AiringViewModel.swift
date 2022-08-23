//
//  AiringViewModel.swift
//  URLTest
//
//  Created by Adrian San Martin on 22/08/22.
//

import Foundation
class AiringViewModel {
    //Crear un Mecanismo para enlazar lo que seria la vista con este Model de la vista
    var refreshDataAiring = { () -> () in }
    //Fuente de datos (Array)
    var dataListAiring: [ResultTv] = [] {
        didSet { refreshDataAiring() }
    }
    //Obtener los datos de la API
    func retriveDataListAiring() {
        guard let url = URL(string: "https://api.themoviedb.org/3/tv/airing_today?api_key=6211d940adfd49ac181b6546b14ff89d&language=en-US&page=1") else { return }
    URLSession.shared.dataTask(with: url) { (data, response, error) in
        guard let json = data else { return }
            do{
                let decoder = JSONDecoder()
                let result = try decoder.decode(TVShow.self, from: json)
                self.dataListAiring = result.results
            }catch let error {
                print("No hay respuesta API AIRING TV: \(error.localizedDescription)")
            }
        }.resume()
    }
}
