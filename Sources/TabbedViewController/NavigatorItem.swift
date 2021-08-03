//
//  File.swift
//  
//
//  Created by jrodrilu on 19/7/21.
//

import Foundation

#if canImport(UIKit)
import UIKit

protocol NavigatorItemProtocol {
    func selectedNavigatorItem(title: String)
}

class NavigatorItem: UIView {
    @IBOutlet private var button: UIButton!
    @IBOutlet private var line: UIView!
    var title: String? {
        didSet {
            button.setTitle(title, for: .normal)
        }
    }
    private var isSelected = false {
        didSet {
            updateColors()
        }
    }
    var primaryColor = UIColor.black {
        didSet {
            updateColors()
        }
    }
    var secondaryColor = UIColor.lightGray {
        didSet {
            updateColors()
        }
    }
    var delegate: NavigatorItemProtocol?
    
    private func updateColors() {
        if isSelected {
            line.isHidden = false
            line.backgroundColor = secondaryColor
            button.setTitleColor(secondaryColor, for: .normal)
        } else {
            let inactiveColor = secondaryColor.withAlphaComponent(0.5)
            line.isHidden = true
            line.backgroundColor = inactiveColor
            button.setTitleColor(inactiveColor, for: .normal)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    static func create(title: String) -> NavigatorItem? {
        let nib = Bundle.main.loadNibNamed("NavigatorItem", owner: self, options: nil)
        let view = nib?.first as? NavigatorItem
        view?.title = title
        view?.line.isHidden = true
        return view
    }
    
    func setSelected(isActive: Bool){
        isSelected = isActive
    }
    
    @IBAction func buttonPerfomed() {
        setSelected(isActive: !isSelected)
        delegate?.selectedNavigatorItem(title: button.title(for: .normal) ?? "")
    }
}
#endif
