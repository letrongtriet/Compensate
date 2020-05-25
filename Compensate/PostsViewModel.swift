//
//  PostsViewModel.swift
//  Compensate
//
//  Created on 24.5.2020.
//  Copyright © 2020 Compensate. All rights reserved.
//

import UIKit

class PostsViewModel {
    
    // MARK: - Dependencies
    let section: PostSection
    
    var newPosts: Closure<[Post]>?
    var error: Closure<String>?
    var isFetching: Closure<Bool>?
    var shouldShowEmptyView: Closure<Bool>?
    
    // MARK: - Private properties
    private let emptyViewMessage = ""
    
    // MARK: - Lifecycels
    init(section: PostSection) {
        self.section = section
        
        NotificationCenter.default.addObserver(self, selector: #selector(getPosts), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    // MARK: - Public methods
    @objc public func getPosts() {
        isFetching?(true)
        
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 1, execute: { [weak self] in
            self?.startGettingPosts()
        })
    }
    
    // MARK: - Private methods
    private func startGettingPosts() {
        NetworkManager.shared.getPosts(section: section, successfulCallback: { [weak self] posts in
            self?.handleNewPosts(posts: posts)
            }, errorCallback: { [weak self] errorString in
                self?.handleError(errorString: errorString)
        })
    }
    
    private func handleNewPosts(posts: [Post]) {
        isFetching?(false)
        
        if !posts.isEmpty {
            newPosts?(posts)
            shouldShowEmptyView?(false)
        } else {
            error?(emptyViewMessage)
            shouldShowEmptyView?(true)
        }
    }
    
    private func handleError(errorString: String) {
        isFetching?(false)
        error?(errorString)
        shouldShowEmptyView?(true)
    }
    
}
