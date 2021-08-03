//
//  menuItem.swift
//  Test
//
//  Created by jrodrilu on 3/8/21.
//

import Foundation
import UIKit

class MenuItem: UIView {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UIButton!
    @IBOutlet weak var button: UIButton!
    
    static public func create(image: UIImage?, action: UIAction, height: CGFloat = 40.0) -> MenuItem {
        let nib = Bundle.main.loadNibNamed("MenuItem", owner: self, options: nil)
        let view = nib?.first as? MenuItem
        view?.titleLabel.setTitle(action.title, for: .normal)
        if image != nil {
            view?.imageView.image = image
        } else {
            view?.imageView.isHidden = true
        }
        view?.imageView.image = image
        view?.button.addAction(action, for: .touchUpInside)
        view?.heightAnchor.constraint(equalToConstant: height).isActive = true
        return view ?? MenuItem()
    }
    
    @IBAction private func titleTapped() {
        button.sendActions(for: .touchUpInside)
    }
    
}
