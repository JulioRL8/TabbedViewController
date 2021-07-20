//
//  File.swift
//  
//
//  Created by jrodrilu on 19/7/21.
//

import Foundation

#if canImport(UIKit)
import UIKit

extension UIStackView {
    @discardableResult
       func removeAllArrangedSubviews() -> [UIView] {
           return arrangedSubviews.reduce([UIView]()) { $0 + [removeArrangedSubViewProperly($1)] }
       }

       func removeArrangedSubViewProperly(_ view: UIView) -> UIView {
           removeArrangedSubview(view)
           NSLayoutConstraint.deactivate(view.constraints)
           view.removeFromSuperview()
           return view
       }
}

#endif
