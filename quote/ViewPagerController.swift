import UIKit

@objc protocol ViewPagerControllerDelegate {
    optional func willMoveToViewControllerAtIndex(index:Int)
    optional func didMoveToViewControllerAtIndex(index:Int)
}

@objc protocol ViewPagerControllerDataSource {
    //Total number of pages required
    func numberOfPages() -> Int
    
    //View Controller for required page at index
    func viewControllerAtPosition(position:Int) -> UIViewController
    
    //Index of page which is to be displayed at first
    optional func startViewPagerAtIndex()->Int
}

class ViewPagerController: UIViewController {
    
    var dataSource : ViewPagerControllerDataSource!
    var delegate : ViewPagerControllerDelegate?
    var options: ViewPagerOptions!
   
    private var pageViewController: UIPageViewController?
    
    var currentPageIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting up View Pager Options
        options.dataSource = self
        
        createPageViewController()
    }
    
    private func getMaximumWidth(widthData:[CGFloat]) -> CGFloat {
        var maxmData = widthData[0]
        
        for data in widthData {
            if data > maxmData {
                maxmData = data
            }
        }
        return maxmData
    }
    
    //MARK: PageViewController Setup
    private func createPageViewController() {
        pageViewController = UIPageViewController(transitionStyle: options.viewPagerTransitionStyle, navigationOrientation: UIPageViewControllerNavigationOrientation.Horizontal, options: nil)
        pageViewController!.dataSource = self
        pageViewController!.delegate = self
        
        pageViewController!.view.frame = CGRectMake(0, 0, options.getViewPagerWidth(), options.getViewPagerHeight())
        
        if dataSource!.numberOfPages() > 0 {
            if let startPage =  dataSource?.startViewPagerAtIndex?() {
                currentPageIndex = startPage
            }
            
            let firstController = getPageItemViewController(currentPageIndex)!
            let startingViewControllers = [firstController]
            pageViewController!.setViewControllers(startingViewControllers, direction: .Forward, animated: false, completion: nil)
         }
        
        self.addChildViewController(pageViewController!)
        self.view.addSubview(pageViewController!.view)
        self.pageViewController!.didMoveToParentViewController(self)
    }
    
    
    private func getPageItemViewController(index: Int) -> UIViewController? {
        if index < dataSource!.numberOfPages() {
            let pageItemViewController = dataSource!.viewControllerAtPosition(index)
            pageItemViewController.view.tag = index
            return pageItemViewController
        }
        return nil
    }
    
    private func displayChoosenViewController(index:Int) {
        let chosenViewController = getPageItemViewController(index)!
        pageViewController!.setViewControllers([chosenViewController], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
    }
}

//MARK: PageViewController Delegates

extension ViewPagerController: UIPageViewControllerDelegate {
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if completed  {
            let pageIndex = pageViewController.viewControllers!.first!.view.tag
            delegate?.didMoveToViewControllerAtIndex?(pageIndex)
        }
        return
    }
    
    func pageViewController(pageViewController: UIPageViewController, willTransitionToViewControllers pendingViewControllers: [UIViewController]) {
        let pageIndex = pendingViewControllers.first!.view.tag
        delegate?.willMoveToViewControllerAtIndex?(pageIndex)
    }
}

//MARK: PageViewController Datasource

extension ViewPagerController: UIPageViewControllerDataSource {
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        if viewController.view.tag > 0 {
            return getPageItemViewController(viewController.view.tag - 1)
        }
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        if viewController.view.tag + 1 < dataSource!.numberOfPages() {
            return getPageItemViewController(viewController.view.tag + 1)
        }
        return nil
    }

}

extension ViewPagerController: ViewPagerOptionsDataSource {
    func viewHeight() -> CGFloat {
        return self.view.bounds.size.height
    }
    
    func viewWidth() -> CGFloat {
        return self.view.bounds.size.width
    }
}
