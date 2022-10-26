import UIKit

final class TabBarViewController: UIViewController {
    
    //MARK: - Private properties
    
    private let tabBar = UITabBarController()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
    }
    
    //MARK: - Private properties
    
    private func configureTabBar() {
        let levelVC = UINavigationController(rootViewController: LevelViewController())
        let progressVC = UINavigationController(rootViewController: ProgressViewController())
        let mainVC = UINavigationController(rootViewController: StartViewController())
        
        levelVC.title = "Level"
        progressVC.title = "Progress"
        mainVC.title = "Main"
        
        levelVC.tabBarItem.image = UIImage(systemName: "gear")
        progressVC.tabBarItem.image = UIImage(systemName: "list.clipboard")
        mainVC.tabBarItem.image = UIImage(systemName: "network")

        tabBar.tabBar.tintColor = .yellowCustomColor
        tabBar.tabBar.unselectedItemTintColor = .lightGray
        tabBar.tabBar.backgroundColor = .white
        tabBar.modalPresentationStyle = .fullScreen
        tabBar.tabBar.backgroundColor = UIColor(red: 19/255, green: 68/255, blue: 37/255, alpha: 1)
        tabBar.setViewControllers([mainVC, progressVC, levelVC], animated: true)
        
        present(tabBar, animated: true)
    }
}
