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

    @IBOutlet private var stackView: UIStackView! {
        didSet {
            updateInfo()
        }
    }
    var delegate: NavigatorDelegate?
    
    private var viewControllerList: [UIViewController]? {
        didSet {
            updateInfo()
        }
    }
    
    private func updateInfo() {
        guard let vcList = viewControllerList,
              stackView != nil else {
            return
        }
        stackView.removeAllArrangedSubviews()
        for vc in vcList {
            let navigatorItem = NavigatorItem.create(title: vc.title ?? "")
            if let navItem = navigatorItem {
                navItem.delegate = self
                stackView.addArrangedSubview(navItem)
            }
        }
    }
    
    var primaryColor: UIColor? {
        didSet {
            self.backgroundColor = primaryColor
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
    
    static func create(viewControllers: [UIViewController]) -> Navigator? {
//        let nib = Bundle.main.loadNibNamed("Navigator", owner: self, options: nil)
//        let view = nib?.first as? Navigator
        let view = Navigator(coder: NSCoder())
        view?.viewControllerList = viewControllers
        return view
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func unselectAllExcept(title: String) {
        stackView.subviews.forEach({ view in
            if let navItem = view as? NavigatorItem
                {
                if navItem.title != title {
                    navItem.setSelected(isActive: false)
                } else {
                    navItem.setSelected(isActive: true)
                }
            }
        })
    }
}

extension Navigator: NavigatorItemProtocol {
    func selectedNavigatorItem(title: String) {
        unselectAllExcept(title: title)
        delegate?.setPage(title: title)
    }
}

extension Navigator: PageControlProtocol {
    func setPage(title: String) {
        unselectAllExcept(title: title)
    }
}

#endif
