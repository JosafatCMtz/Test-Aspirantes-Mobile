//
//  MovieDetailController.swift
//  Test_Aspirantes
//
//  Created by Josafat Martínez  on 05/01/21.
//

import AVFoundation
import AVKit
import UIKit

struct MovieDetail {
    let name, classification, genere, duration, synopsis: String
}
class MovieDetailController: UIViewController {
    
    public var urlString: String?
    public var movieDetail: MovieDetail?
    @IBOutlet var videoPlayerView: UIView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieClassificationLabel: UILabel!
    @IBOutlet weak var movieGenreLabel: UILabel!
    @IBOutlet weak var movieDurationLabel: UILabel!
    @IBOutlet weak var movieSynopsisLabel: UITextView!
    fileprivate func setUpUIWithDataFrom(_ movie: MovieDetail) {
        movieNameLabel.text = movie.name
        movieClassificationLabel.text = movie.classification
        movieGenreLabel.text = movie.genere
        movieDurationLabel.text = movie.duration
        movieSynopsisLabel.text = movie.synopsis
        movieSynopsisLabel.isEditable = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let movie = movieDetail else { return }
        setUpUIWithDataFrom(movie)
        title = movie.name
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let urlString = self.urlString else { return }
        if let url = URL(string: urlString) {
            let player = AVPlayer(url: url)
            let controller = AVPlayerViewController()
            controller.player = player
            controller.view.frame = videoPlayerView.frame
            videoPlayerView.addSubview(controller.view)
            addChild(controller)
            player.play()
        }
    }
}
