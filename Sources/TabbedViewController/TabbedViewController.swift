
#if canImport(UIKit)
import UIKit

public class TabbedViewController: UIViewController {
    
    @IBOutlet private var pageViewContainer: UIView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var header: UIView!
    public override var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    private var primaryColor: UIColor = .black {
        didSet {
            header.backgroundColor = primaryColor
            navigator?.primaryColor = primaryColor
        }
    }
    private var secondaryColor: UIColor = .lightGray {
        didSet {
            navigator?.secondaryColor = secondaryColor
        }
    }
    
    private var navigator: Navigator?
    
    @IBOutlet private var stackViewPageViewContainer: UIStackView!
    @IBOutlet private var stackViewNavigator: UIStackView!
    
    private var pageViewController: PageViewController? {
        didSet {
            if let pvController = pageViewController {
                stackViewPageViewContainer.removeAllArrangedSubviews()
                stackViewPageViewContainer.addArrangedSubview(pvController.view)
            }
        }
    }
    public var viewControllers = [UIViewController]() {
        didSet {
            pageViewController = PageViewController(viewControllers: viewControllers)
            navigator = Navigator(viewControllers: viewControllers)
            navigator?.delegate = pageViewController
        }
    }
    
    public init(viewControllerList: [UIViewController]) {
        super.init(nibName: nil, bundle: nil)
        self.viewControllers = viewControllerList
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public func setColor(primary: UIColor, secondary: UIColor) {
        self.primaryColor = primary
        self.secondaryColor = secondary
    }
}


#endif
