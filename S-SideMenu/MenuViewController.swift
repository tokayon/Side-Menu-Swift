//
//  MenuViewController.swift
//  S-SideMenu
//
//  Created by SergeSinkevych and Jarrod Parkes on 23.04.16.
//  Copyright © 2016 Sergii Sinkevych. All rights reserved.
//

import UIKit

// MARK: - MenuViewController: UIViewController

class MenuViewController: UIViewController {
    
    // MARK: Properties
    
    let menuItems = ["First", "Second", "Third", "RandomColor"]
    
    // MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var containerView: UIView!
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = menuItems[0]
        setupColors()
        addRecognizers()
        
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        tableView.selectRowAtIndexPath(indexPath, animated: false, scrollPosition: .Top)
    }
    
    // MARK: Actions
    
    @IBAction func menuButtonPressed(sender: AnyObject) {
        
        containerView.frame.origin.x > 0 ? hideMenu() : showMenu()
        
    }
    
    // MARK: Common methods
    
    func setupColors() {
        tableView.backgroundColor = Constants.Colors.menuBackgroundColor
        navigationController?.navigationBar.tintColor = Constants.Colors.menuBackgroundColor
        navigationController?.navigationBar.titleTextAttributes = Constants.titleTextColor(Constants.Colors.menuBackgroundColor)
        tableView.tintColor = Constants.Colors.menuTextColor
    }
    
    func addRecognizers() {
        let leftSwipe = UISwipeGestureRecognizer.init(target: self, action: #selector(MenuViewController.handleLeftSwipe(_:)))
        leftSwipe.direction = UISwipeGestureRecognizerDirection.Left
        view.addGestureRecognizer(leftSwipe)
        let rightSwipe = UISwipeGestureRecognizer.init(target: self, action: #selector(MenuViewController.handleRightSwipe(_:)))
        rightSwipe.direction = UISwipeGestureRecognizerDirection.Right
        view.addGestureRecognizer(rightSwipe)
        
    }
    
    func handleRightSwipe(gesture: UISwipeGestureRecognizer) {
        if containerView.frame.origin.x == 0 {
            showMenu()
        }
    }
    
    func handleLeftSwipe(gesture: UISwipeGestureRecognizer) {
        if containerView.frame.origin.x > 0 {
            hideMenu()
        }
    }
    
    
    // MARK: Show/Hide Menu
    
    func showMenu() {
        UIView.animateWithDuration(0.35) {
            self.slideTopViewsPercentWidth(0.2)
        }
    }
    
    func hideMenu() {
        UIView.animateWithDuration(0.35) {
            self.slideTopViewsPercentWidth(1)
        }
    }
    
    func slideTopViewsPercentWidth(percentWidth: CGFloat) {
        let xPercentage = 1 - percentWidth
        let tableViewFrame = tableView.frame
        let containerViewFrame = containerView.frame
        if let navigationController = navigationController {
            navigationController.navigationBar.frame = CGRect(x: tableViewFrame.size.width * xPercentage,
                                                              y: navigationController.navigationBar.frame.origin.y,
                                                              width: navigationController.navigationBar.frame.size.width,
                                                              height: navigationController.navigationBar.frame.size.height)
        }
        
        self.containerView.frame = CGRect(x: containerViewFrame.size.width * xPercentage,
                                          y: containerViewFrame.origin.y,
                                          width: containerViewFrame.size.width,
                                          height: containerViewFrame.size.height)
    }
}

// MARK: - MenuViewController: UITableViewDelegate

extension MenuViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.cellForRowAtIndexPath(indexPath)?.backgroundColor = Constants.Colors.selectedMenuItemColor
        if let previousVC = childViewControllers.last {
            previousVC.removeFromParentViewController()
            previousVC.view.removeFromSuperview()
        }
        var nextVC: UIViewController? = nil
        switch indexPath.row {
        case 0:
            nextVC = storyboard!.instantiateViewControllerWithIdentifier("firstVC")
        case 1:
            nextVC = storyboard!.instantiateViewControllerWithIdentifier("secondVC")
        case 2:
            nextVC = storyboard!.instantiateViewControllerWithIdentifier("thirdVC")
        case 3:
            nextVC = storyboard!.instantiateViewControllerWithIdentifier("randomVC")
            nextVC?.view.backgroundColor = UIColor.randomColor()
        default:
            break
        }
        
        navigationItem.title = menuItems[indexPath.row]
        navigationController?.navigationBar.titleTextAttributes = Constants.titleTextColor(Constants.Colors.menuBackgroundColor)
        
        addChildViewController(nextVC!)
        containerView.addSubview(nextVC!.view)
        hideMenu()
    }
    
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        if let currentSelectedIndexPath = tableView.indexPathForSelectedRow {
            tableView.cellForRowAtIndexPath(currentSelectedIndexPath)?.backgroundColor = Constants.Colors.menuBackgroundColor
        }
        return indexPath
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if cell.selected {
            cell.backgroundColor = Constants.Colors.selectedMenuItemColor
        } else {
            cell.backgroundColor = Constants.Colors.menuBackgroundColor
        }
    }
}

// MARK: - MenuViewController: UITableViewDataSource

extension MenuViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("tableCell") as UITableViewCell!
        cell.selectionStyle = .None
        cell.textLabel?.textColor = Constants.Colors.menuTextColor
        let separator = CALayer.init()
        separator.backgroundColor = Constants.Colors.separatorCGColor
        separator.frame = CGRect(x: 0, y: cell.frame.size.height - 1, width: cell.frame.size.width, height: 0.5)
        cell.layer.addSublayer(separator)
        cell.textLabel?.text = menuItems[indexPath.row]
        return cell
    }
}