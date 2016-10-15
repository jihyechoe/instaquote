import Foundation
import UIKit

protocol ViewPagerOptionsDataSource {
    func viewHeight() -> CGFloat
    func viewWidth() -> CGFloat
}

class ViewPagerOptions {
    var dataSource:ViewPagerOptionsDataSource!
    
    //MARK: View Pager Properties
    var viewPagerTransitionStyle:UIPageViewControllerTransitionStyle!
    
    //MARK: View Pager Internal Methods
    init() {
        setDefaults()
    }
   
    /*
    Sets defaults values for viewpager and view pager tabs during initialization of options.
    These values can be overridden after initialization through respective properties
    */
    private func setDefaults() {
        //View Pager Defaults
        viewPagerTransitionStyle = UIPageViewControllerTransitionStyle.Scroll
    }
    
    /*
    Calculate height of viewpager pages from the given frame
    
    - returns: Height of viewpager in CGFloat
    */
    func getViewPagerHeight() -> CGFloat {
        return dataSource!.viewHeight() 
    }
    
    /*
    Calculate width of viewpager pages from the given frame
    
    - returns: Width of viewpager in CGFloat
    */
    func getViewPagerWidth() -> CGFloat {
        return dataSource!.viewWidth()
    }
    
}