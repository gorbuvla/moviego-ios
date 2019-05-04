//
//  MovieListViewModel.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 10/04/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import RxSwift

class ShowtimeListViewModel: BaseViewModel {
    
    private let repository: ShowtimeRepositoring
    private let viewStateVariable = Variable(LoadingResult<[Showtime]>(false))
    
    var viewState: ObservableProperty<[Showtime]> {
        get { return viewStateVariable.asObservable() }
    }
    
    init(repository: ShowtimeRepositoring) {
        self.repository = repository
    }
    
    func fetchInitial() {
        
    }
    
    func fetchNext() {
        
    }
}
