//
//  MoviesViewModel.swift
//  Test_Aspirantes
//
//  Created by Josafat Martínez  on 05/01/21.
//

import Foundation

protocol MoviesViewModelDelegate {
    func getMovies()
}

class MoviesViewModel: MoviesViewModelDelegate {
    var api = APIService()
    var delegate: MoviesControllerDelegate?
    func getMovies() {
        api.getMovies { (result) in
            switch result {
            case .success(let movies):
                self.delegate?.getMoviesData(handelData: movies)
            case .failure(let error):
                self.delegate?.showErrorAlert(errorMessages: error.rawValue)
            }
        }
    }

}
