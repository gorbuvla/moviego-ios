//
//  PromotionRepository.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 09/05/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import Foundation
import RxSwift

protocol PromotionRepositoring {
    
    func fetchPromotions() -> Single<[Promotion]>
}

class MockedPromotionRepository: PromotionRepositoring {
    
    private let bond25 = Movie(
        title: "Bond 25",
        year: "2020",
        imdbRating: 7.3,
        imdbId: "tt2382320",
        rottenTomatoesRating: "73%",
        plot: "Bond has left active service. His peace is short-lived when his old friend Felix Leiter from the CIA turns up asking for help, leading Bond onto the trail of a mysterious villain armed with dangerous new technology.",
        poster: URL(string: "https://m.media-amazon.com/images/M/MV5BM2E5ODliOGMtY2Q5My00ODFlLTk5NGItODFmNjU4YzM5NDA3XkEyXkFqcGdeQXVyNjUwNzk3NDc@._V1_SX300.jpg")!,
        release: "08 Apr 2020",
        trailer: "https://www.youtube.com/watch?v=NHwT8adPgQE",
        director: Person(name: "Cary Joji Fukunaga"),
        actors: "Rami Malek, Daniel Craig, Ana de Armas, Ralph Fiennes".components(separatedBy: ", ").map { Person(name: $0) }
    )
    
    private let spiderMan = Movie(
        title: "Spider-Man: Far From Home",
        year: "2019",
        imdbRating: 7.3,
        imdbId: "tt6320628",
        rottenTomatoesRating: "73%",
        plot: "Peter Parker and his friends go on a European vacation, where Peter finds himself agreeing to help Nick Fury uncover the mystery of several elemental creature attacks, creating havoc across the continent.",
        poster: URL(string: "https://m.media-amazon.com/images/M/MV5BZjBhYWNiMDQtYjRmYy00NzEzLTg1MDYtYzg3YzRkZmRkYjY3XkEyXkFqcGdeQXVyNjg2NjQwMDQ@._V1_SX300.jpg")!,
        release: "05 Jul 2019",
        trailer: "https://www.youtube.com/watch?v=Nt9L1jCKGnE",
        director: Person(name: "Jon Watts"),
        actors: "Rami Malek, Daniel Craig, Ana de Armas, Ralph Fiennes".components(separatedBy: ", ").map { Person(name: $0) }
    )
    
    
    func fetchPromotions() -> Single<[Promotion]> {
        return Single.just([])
    }
}
