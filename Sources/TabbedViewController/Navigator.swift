//
//  File.swift
//  
//
//  Created by jrodrilu on 19/7/21.
//

import Foundation

#if canImport(UIKit)
import UIKit

protocol NavigatorDelegate {
    func setPage(title: String)
}

class Navigator: UIView {

    @IBOutlet private var stackView: UIStackView!
    var delegate: NavigatorDelegate?
    
    private var viewControllerList: [UIViewController] {
        didSet {
            for vc in viewControllerList {
                let navigatorItem = NavigatorItem(title: vc.title ?? "")
                stackView.addArrangedSubview(navigatorItem)
            }
        }
    }
    
    var primaryColor: UIColor? {
        didSet {
            stackView.subviews.forEach({ view in
                if let navItem = view as? NavigatorItem,
                   let color = primaryColor {
                    navItem.primaryColor = color
                }
            })
        }
    }
    
    var secondaryColor: UIColor? {
        didSet {
            stackView.subviews.forEach({ view in
                if let navItem = view as? NavigatorItem,
                   let color = secondaryColor {
                    navItem.secondaryColor = color
                }
            })
        }
    }
    
    init(viewControllers: [UIViewController]) {
        viewControllerList = viewControllers
        super.init(frame: CGRect(x: 0, y: 0, width: 1920, height: 1080))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension Navigator: NavigatorItemProtocol {
    func selectedNavigatorItem(title: String) {
        delegate?.setPage(title: title)
    }
}

#endif
