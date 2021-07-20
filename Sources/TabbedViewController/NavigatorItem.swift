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
    private var isSelected = false {
        didSet {
            if isSelected {
                line.backgroundColor = primaryColor
                button.setTitleColor(primaryColor, for: .normal)
            } else {
                line.backgroundColor = secondaryColor
                button.setTitleColor(secondaryColor, for: .normal)
            }
        }
    }
    var primaryColor = UIColor.black {
        didSet {
            if isSelected {
                line.backgroundColor = primaryColor
                button.setTitleColor(primaryColor, for: .normal)
            }
        }
    }
    var secondaryColor = UIColor.lightGray {
        didSet {
            if !isSelected {
                line.backgroundColor = secondaryColor
                button.setTitleColor(secondaryColor, for: .normal)
            }
        }
    }
    var delegate: NavigatorItemProtocol?
    
    
    init(title: String) {
        super.init(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 1920, height: 1080)))
        button.setTitle(title, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
