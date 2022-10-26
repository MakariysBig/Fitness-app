import UIKit

final class LevelViewController: UIViewController {
    
    //MARK: - Private propertie
    
    private var rootView: LevelView {
        self.view as! LevelView
    }
    
    private let userDefaults = UserDefaults.standard
    private var level: Int = 1
    
    //MARK: - Lifecycle
    
    override func loadView() {
        self.view = LevelView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateData()
        setupTarget()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateData()
    }
    
    //MARK: - Private methode
    
    private func updateData() {
        level = userDefaults.integer(forKey: "userLevel")
        rootView.currentLevelLabel.text = "\(level)"
    }
    
    private func setupTarget() {
        rootView.minusLevelButton.addTarget(self, action: #selector(minusLevelAction), for: .touchUpInside)
        rootView.plusLevelButton.addTarget(self, action: #selector(plusLevelAction), for: .touchUpInside)
    }
    
    private func updateLevel() {
        let levelStr = String(level)
        rootView.currentLevelLabel.text = levelStr
        userDefaults.set(level, forKey: "userLevel")
    }
    
    //MARK: - Private action
    
    @objc private func minusLevelAction() {
        if level == 1 {
            level = 1
            updateLevel()
        } else {
            level -= 1
            updateLevel()
        }
    }
    
    @objc private func plusLevelAction() {
        if level == 5 {
            level = 5
            updateLevel()
        } else {
            level += 1
            updateLevel()
        }
    }
}
