//
//  TopMovieModel.swift
//  URLTest
//
//  Created by Adrian San Martin on 22/08/22.
//

import Foundation

class TopMovieModel{
    //Crear un Mecanismo para enlazar lo que seria la vista con este Model de la vista
    var refreshDataTopMovie = { () -> () in }
    //Fuente de datos (Array)
    var dataListTopMovie: [ResultTopMovie] = [] {
        didSet { refreshDataTopMovie() }
    }
    //Obtener los datos de la API
    func retriveDataListTopMovie() {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=6211d940adfd49ac181b6546b14ff89d&language=en-US&page=1") else { return }
    URLSession.shared.dataTask(with: url) { (data, response, error) in
        guard let json = data else { return }
            do{
                let decoder = JSONDecoder()
                let result = try decoder.decode(TopMovie.self, from: json)
                print("TOP MOVIE &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&")
                print(result)
                self.dataListTopMovie = result.results
            }catch let error {
                print("No hay respuesta API TOP : \(error.localizedDescription)")
            }
        }.resume()
    }
}
