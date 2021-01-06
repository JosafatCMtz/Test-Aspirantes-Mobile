//
//  MovieCollectionViewCell.swift
//  Test_Aspirantes
//
//  Created by Josafat Martínez  on 05/01/21.
//

import UIKit

protocol ReusableViews: AnyObject {
    static var identifier: String { get }
}

final class MovieCollectionViewCellClass: UICollectionViewCell {
    private let movieImageView: UIImageView = {
           let imageView = UIImageView(frame: .zero)
           imageView.contentMode = .scaleAspectFill
           return imageView
       }()

       let nameMovieLabel: UILabel = {
           let label = UILabel(frame: .zero)
           label.textAlignment = .center
           return label
       }()
    func setup(movieName name: String, withUrlForImage urlString: String) {
        nameMovieLabel.text = name
        movieImageView.load(urlString: urlString)
        movieImageView.contentMode = .scaleAspectFill
    }
}

extension MovieCollectionViewCellClass {
    static var identifier: String {
        return String(describing: self)
    }
}
