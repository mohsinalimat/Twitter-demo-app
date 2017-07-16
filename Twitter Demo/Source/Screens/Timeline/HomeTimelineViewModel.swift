//
//  HomeTimelineViewModel.swift
//  Twitter Demo
//
//  Created by Luis Valdés on 16/7/17.
//  Copyright © 2017 Luis Valdés Cuesta. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa

final class HomeTimelineViewModel: TimelineViewModel {
    
    var showUserProfile: (String) -> Void = { _ in }
    
    private let repository: TwitterRepository
    
    let windowTitleDriver: Driver<String>
    let tweetsDriver: Driver<[TweetCellViewModel]>
    
    init(repository: TwitterRepository) {
        self.repository = repository
        
        windowTitleDriver = Driver.just("Timeline")
        
        tweetsDriver = repository.retrieveTweets()
            .map { tweets in
                tweets.map { TweetCellViewModel(repository: repository, tweet: $0) }
            }
            .asDriver(onErrorJustReturn: [])
    }
    
    func didSelectCellViewModel(_ cellViewModel: TweetCellViewModel) {
        showUserProfile(cellViewModel.userID)
    }
}