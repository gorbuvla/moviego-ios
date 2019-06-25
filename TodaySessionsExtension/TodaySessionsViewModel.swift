//
//  TodaySessionsViewModel.swift
//  TodaySessionsExtension
//
//  Created by Vlad Gorbunov on 25/06/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import CoreData

typealias TodaySessionsDelegate = NSFetchedResultsControllerDelegate

final class TodaySessionsViewModel: NSFetchedResultsController<DBMovie> {
    
    override init() {
        let request: NSFetchRequest<DBMovie> = DBMovie.fetchRequest()
        
        request.sortDescriptors = [
            NSSortDescriptor(key: "tomatoesRating", ascending: true, selector: #selector(NSString.localizedStandardCompare(_:))),
            NSSortDescriptor(key: "imdbRating", ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))
        ]
    
        super.init(fetchRequest: request, managedObjectContext: Database.shared.mainContext, sectionNameKeyPath: "title", cacheName: nil)
    }
}
