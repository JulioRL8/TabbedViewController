
#if canImport(UIKit)
import UIKit

public class TabbedViewController: UIViewController {
    // MARK: -VARS AND OUTLETS
    @IBOutlet public weak var settingsButton: UIButton!
    @IBOutlet public weak var menuButton: UIButton!
    
    @IBOutlet weak var headerHeight: NSLayoutConstraint?
    @IBOutlet weak var navigatorHeight: NSLayoutConstraint?
    @IBOutlet weak var navigatorView: UIView!
    @IBOutlet private var pageViewContainer: UIView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var header: UIView!
    @IBOutlet private var settingsStackView: UIStackView!
    @IBOutlet private var settingsView: UIView! {
        didSet {
            settingsView.isHidden = true
        }
    }
    @IBOutlet weak var menuView: UIView!
    
    @IBOutlet weak var menuStackView: UIStackView!
    
    private var settingsActions: [UIAction] = [] {
        didSet {
            updateSettingsActions()
        }
    }
    private var menuActions: [UIAction] = [] {
        didSet {
            updateMenuActions()
        }
    }
    
    public override var title: String? {
        didSet {
            if titleLabel != nil {
                titleLabel.text = title
            }
        }
    }
    
    public var withHeader = true {
        didSet {
            header?.isHidden = withHeader
        }
    }
    private var withNav = true {
        didSet {
            navigator?.isHidden = withNav
        }
    }
    
    public var primaryColor: UIColor = .black {
        didSet {
            updateColors()
        }
    }
    public var secondaryColor: UIColor = .lightGray {
        didSet {
            updateColors()
        }
    }
    
    private var terciaryColor: UIColor = .blue {
        didSet{
            updateColors()
        }
    }
    
    private var menuButtonColor: UIColor? {
        didSet {
            updateMenuActions()
        }
    }
    
    private var settingsButtonColor: UIColor? {
        didSet {
            updateSettingsActions()
        }
    }
    
    var navigator: Navigator? {
        didSet {
            updateNavigator()
        }
    }
    
    private var pageViewController: PageViewController? {
        didSet {
            updatePageViewController()
        }
    }
    public var viewControllers: [UIViewController] {
        didSet {
            pageViewController = PageViewController(viewControllers: viewControllers)
            navigator = Navigator.create(viewControllers: viewControllers)
            navigator?.delegate = pageViewController
            pageViewController?.pageControl = navigator
        }
    }
    @IBOutlet weak var menuStackViewHeight: NSLayoutConstraint!
    // MARK: -INITS
    
    private init(viewControllerList: [UIViewController], withHeader: Bool = true, withNavigator: Bool = true) {
        self.viewControllers = viewControllerList
        pageViewController = PageViewController(viewControllers: viewControllers)
        navigator = Navigator.create(viewControllers: viewControllers)
        navigator?.delegate = pageViewController
        self.withHeader = withHeader
        self.withNav = withNavigator
        
        super.init(nibName: "TabbedViewController", bundle: Bundle.module)
    }
    
    static public func create(viewControllerList: [UIViewController], withHeader: Bool = true, withNavigator: Bool = true) -> TabbedViewController {
        let view = TabbedViewController(viewControllerList: viewControllerList, withHeader: withHeader, withNavigator: withNavigator)
        return view
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        initializeView()
        titleLabel?.text = title
        updateColors()
        header?.isHidden = !withHeader
        navigatorView?.isHidden = !withNav
    }
    
    private func initializeView() {
        pageViewController?.removeFromParent()
        pageViewController = PageViewController(viewControllers: viewControllers)
        navigator = Navigator.create(viewControllers: viewControllers)
        navigator?.delegate = pageViewController
        
        updateNavigator()
        updatePageViewController()
        updateSettingsActions()
        updateMenuActions()
    }
    
    // MARK: -UI UPDATES
    
    private func updateColors() {
        if header != nil {
            header.backgroundColor = primaryColor
        }
        settingsButton?.tintColor = secondaryColor
        menuButton?.tintColor = secondaryColor
        titleLabel?.textColor = secondaryColor
        navigator?.primaryColor = primaryColor
        navigator?.secondaryColor = secondaryColor
    }
    
    private func updateSettingsActions() {
        settingsStackView?.removeAllArrangedSubviews()
        settingsActions.forEach({ action in
            let button = UIButton(primaryAction: action)
            if let color = settingsButtonColor {
                button.setTitleColor(color, for: .normal)
            } else {
                button.setTitleColor(primaryColor, for: .normal)
            }
            let closeAction = UIAction(handler: { action in
                self.closeSettings()
            })
            button.addAction(closeAction, for: .touchUpInside)
            settingsStackView?.addArrangedSubview(button)
        })
    }
    
    private func updateViewControllerList() {
    }
    
    private func updatePageViewController() {
        if let pvController = pageViewController, pageViewContainer != nil {
            self.addChild(pvController)
            self.pageViewContainer.addSubview(pvController.view)
            pvController.view.frame = pageViewContainer.bounds
            
            NSLayoutConstraint.activate([
                pvController.view.leadingAnchor.constraint(equalTo: pageViewContainer.leadingAnchor, constant: 0),
                pvController.view.trailingAnchor.constraint(equalTo: pageViewContainer.trailingAnchor, constant: 0),
                pvController.view.topAnchor.constraint(equalTo: pageViewContainer.topAnchor, constant: 0),
                pvController.view.bottomAnchor.constraint(equalTo: pageViewContainer.bottomAnchor, constant: 0)
            ])
            
            pvController.didMove(toParent: self)
            navigator?.delegate = pageViewController
        }
    }
    
    private func updateNavigator() {
        if let nav = navigator, navigatorView != nil {
            nav.translatesAutoresizingMaskIntoConstraints = false
            navigatorView.addSubview(nav)
            nav.trailingAnchor.constraint(equalTo: navigatorView.trailingAnchor).isActive = true
            nav.leadingAnchor.constraint(equalTo: navigatorView.leadingAnchor).isActive = true
            nav.topAnchor.constraint(equalTo: navigatorView.topAnchor).isActive = true
            nav.bottomAnchor.constraint(equalTo: navigatorView.bottomAnchor).isActive = true
            pageViewController?.pageControl = nav
        }
    }
    
    private func updateMenuActions() {
        menuStackView?.removeAllArrangedSubviews()
        menuActions.forEach({ action in
            let menuItem = MenuItem.create(image: nil, action: action)
            if let titleColor = menuButtonColor {
                menuItem.titleLabel.setTitleColor(titleColor, for: .normal)
            }
            menuStackView?.addArrangedSubview(menuItem)
        })
    }
    
    // MARK: -SETTERS
    
    public func setNavigatorColor(color: UIColor) {
        navigator?.backgroundColor = color
    }
    
    public func setHeightNavigator(height: CGFloat) {
        navigatorHeight?.constant = height
    }
    public func setHeaderHeight(height: CGFloat) {
        headerHeight?.constant = height
    }
    
    public func addSettingsAction(title: String, action: @escaping (UIAction)->()) {
        let uiAction = UIAction(title: title, handler: action)
        settingsActions.append(uiAction)
    }
    
    public func addMenuAction(title: String, action: @escaping (UIAction)->() ) {
        let uiAction = UIAction(title: title, handler: action)
        menuActions.append(uiAction)
    }
    
    public func setMenuButtonsColor(color: UIColor) {
        menuButtonColor = color
    }
    
    public func setSettingsColor(color: UIColor) {
        
    }
    
    public func setColors(primary: UIColor, secondary: UIColor) {
        self.primaryColor = primary
        self.secondaryColor = secondary
    }
    
    // MARK: -IBACTIONS
    
    @IBAction private func settingsPressed() {
        if !settingsView.isHidden {
            closeSettings()
        } else {
            openSettings()
        }
    }
    
    @IBAction private func closeSettings() {
        UIView.animateKeyframes(withDuration: 0.1, delay: 0, animations: {
            self.settingsView.alpha = 0
        }, completion: { _ in
            self.settingsView.isHidden = true
        })
    }
    
    private func openSettings() {
        settingsView.alpha = 0
        settingsView.isHidden = false
        UIView.animateKeyframes(withDuration: 0.1, delay: 0, animations: {
            self.settingsView.alpha = 1
        }, completion: nil)
    }
    
    @IBAction private func menuPressed() {
        if menuView.isHidden {
            openMenu()
        } else {
            closeMenu()
        }
    }
    
    private func openMenu() {
        menuStackViewHeight.constant = 0.0
        menuView.isHidden = false
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
            self.menuStackViewHeight.constant = 250.0
            self.view.layoutIfNeeded()
        })
    }
    
    private func closeMenu() {
        UIView.animateKeyframes(withDuration: 0.2, delay: 0, animations: {
             self.menuStackViewHeight.constant = 0.0
            self.view.layoutIfNeeded()
        }, completion: { _ in
            self.menuView.isHidden = true
        })
    }
}
#endif
