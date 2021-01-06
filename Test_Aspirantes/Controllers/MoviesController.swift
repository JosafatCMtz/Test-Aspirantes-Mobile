//
//  MoviesController.swift
//  Test_Aspirantes
//
//  Created by Josafat Martínez  on 05/01/21.
//

import UIKit

protocol MoviesControllerDelegate {
    func getMoviesData(handelData: Movies?)
    func showErrorAlert(errorMessages: String)
}

private enum SizeForImages: String {
    case large
    case medium
    case small
    case xLarge = "x-large"
}

class MoviesController: UIViewController {
    private var viewModel = MoviesViewModel()
    private var movies: [Movie] = []
    private var routes: [Route] = []
    @IBOutlet var moviesCollectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.getMovies()
        title = "Cartelera"
    }

    fileprivate func getUrlPathForImage(size: SizeForImages,
                                        typeOfSource type: Code, from content: [Media]) -> String? {
        var resource: String?
        content.forEach { media in
            if media.code.rawValue == type.rawValue {
                resource = media.resource
            }
        }
        var finalRoute: String?
        routes.forEach { route in
            if route.code.rawValue == type.rawValue {
                switch size {
                case .small:
                    finalRoute = "\(route.sizes.small ?? "")\(resource ?? "")"
                default:
                    finalRoute = "\(route.sizes.medium)\(resource ?? "")"
                }
            }
        }
        return finalRoute
    }
}

extension MoviesController: MoviesControllerDelegate {
    func getMoviesData(handelData: Movies?) {
        guard let data = handelData else { return }
        let movies = data.movies
        let routes = data.routes
        self.movies = movies
        self.routes = routes
        activityIndicator.stopAnimating()
        moviesCollectionView.reloadData()
    }

    func showErrorAlert(errorMessages: String) {
        let alert = UIAlertController(title: "Upss!", message: errorMessages, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true)
    }
}

extension MoviesController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = moviesCollectionView.dequeueReusableCell(
            withReuseIdentifier: "CellReuseIdentifier",
            for: indexPath) as! MovieCollectionViewCell
        let movie = movies[indexPath.row]
        cell.movieNameLabel.text = movie.name
        cell.moviePosterImageView.load(
            urlString: getUrlPathForImage(size: .medium,
                                          typeOfSource: .poster,
                                          from: movie.media)!)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.size.width - 16)
        return CGSize(width: size, height: size)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let movieDetailController = storyboard?.instantiateViewController(
            withIdentifier: "MovieDetailController") as? MovieDetailController {
            let movie = movies[indexPath.row]
            let movieDetail: MovieDetail = .init(
                name: movie.name,
                classification: movie.rating,
                genere: movie.genre,
                duration: movie.length,
                synopsis: movie.synopsis)
            movieDetailController.movieDetail = movieDetail
            movieDetailController.urlString = self.getUrlPathForImage(
                size: .medium,
                typeOfSource: .trailerMp4,
                from: movie.media)!
            present(movieDetailController, animated: true, completion: nil)
        }
    }
}
