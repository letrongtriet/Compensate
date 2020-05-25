//
//  UITableView+Extension.swift
//  Compensate
//
//  Created on 24.5.2020.
//  Copyright © 2020 Compensate. All rights reserved.
//

import UIKit

extension UITableView {
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }

    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .none
    }
    
    func programaticallyBeginRefreshing() {
        guard let refreshControl = refreshControl else { return }
        
        refreshControl.beginRefreshing()
        let offsetPoint = CGPoint.init(x: 0, y: -refreshControl.frame.size.height)
        setContentOffset(offsetPoint, animated: true)
    }
    
    func reloadDataAnimated() {
        UIView.transition(with: self, duration: 0.35, options: .transitionCrossDissolve, animations: {
            self.reloadData()
        }, completion: { _ in
            self.refreshControl?.endRefreshing()
        })
    }
}
