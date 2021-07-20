//
//  File.swift
//  
//
//  Created by jrodrilu on 19/7/21.
//
import UIKit

protocol PageControlProtocol {
    func setPage(index: Int)
    func setPage(vc: UIViewController)
}

class PageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    private var vcList = [UIViewController]()
    
    lazy var viewControllerList:[UIViewController] = {
        return vcList
    }()
    
    init(viewControllers: [UIViewController]) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.vcList = viewControllers
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var pageControl: PageControlProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.dataSource = self
        self.delegate = self
        
        
        if let firstViewController = viewControllerList[1] as UIViewController? {
            self.setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
        
        self.view.backgroundColor = UIColor(red: 0.73333, green: 0.6941, blue: 0.5607, alpha: 1)
        // Do any additional setup after loading the view.
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = viewControllerList.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        
        guard nextIndex >= 0 else {
            return nil
        }
        
        guard viewControllerList.count > nextIndex else {
            return nil
        }
        
        return viewControllerList[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = viewControllerList.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard viewControllerList.count > previousIndex else {
            return nil
        }
        
        return viewControllerList[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if let currentVC = pageViewController.viewControllers?.last {
            if let pc = pageControl {
                pc.setPage(vc: currentVC)
            }
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        
        if let pc = pageControl {
            pc.setPage(vc: pendingViewControllers[0])
        }
    }
    
    func flipToPage(id: Int) {
        let vcToGo = self.viewControllerList[id]
        let index = self.viewControllerList.firstIndex(of: vcToGo)
        guard let currentVC = self.viewControllers?.first else { return }
        let indexCurrentVC = self.viewControllerList.lastIndex(of: currentVC)
        
        let direction: UIPageViewController.NavigationDirection
        if index! > indexCurrentVC! {
            direction = .forward
        } else {
            direction = .reverse
        }
        
        self.setViewControllers([vcToGo], direction: direction, animated: true, completion: nil)
        pageControl?.setPage(vc: vcToGo)
    }
    
    func flipToPage(title: String) {
        let viewController = vcList.filter({ vc in
            vc.title == title
        })
        if !viewController.isEmpty,
           let index = vcList.firstIndex(of: viewController[0]) {
            flipToPage(id: index)
        }
    }
}

extension PageViewController: NavigatorDelegate {
    func setPage(title: String) {
        flipToPage(title: title)
    }
}
