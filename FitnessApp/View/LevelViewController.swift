import UIKit

final class LevelViewController: UIViewController {
    
    //MARK: - Private propertie
    
    private let userDefaults = UserDefaults.standard
    private var level: Int = 1
    
    private let levelLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        label.textAlignment = .center
        label.text = "LEVEL"
        label.textColor = .yellowCustomColor
        
        return label
    }()

    private let currentLevelLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        label.textAlignment = .center
        label.text = "1"
        label.textColor = .yellowCustomColor
        
        return label
    }()
    
    private let plusLevelButton: UIButton = {
        let button = UIButton()
        
        button.setBackgroundImage(UIImage(systemName: "plus.circle"), for: .normal)
        button.tintColor = .yellowCustomColor
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private let minusLevelButton: UIButton = {
        let button = UIButton()
        
        button.setBackgroundImage(UIImage(systemName: "minus.circle"), for: .normal)
        button.tintColor = .yellowCustomColor
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        updateData()
        setup()
        setupTarget()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateData()
    }
    
    //MARK: - Private methode
    
    private func updateData() {
        level = userDefaults.integer(forKey: "userLevel")
        currentLevelLabel.text = "\(level)"
    }
    
    private func setup() {
        view.backgroundColor = .greenCustomColor
        view.addSubview(minusLevelButton)
        view.addSubview(currentLevelLabel)
        view.addSubview(plusLevelButton)
        view.addSubview(levelLabel)
        updateConstraints()
    }
    
    private func updateConstraints() {
        NSLayoutConstraint.activate([
            levelLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            levelLabel.bottomAnchor.constraint(equalTo: currentLevelLabel.topAnchor, constant: -50),
            levelLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            levelLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            currentLevelLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currentLevelLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            currentLevelLabel.heightAnchor.constraint(equalToConstant: 50),
            currentLevelLabel.widthAnchor.constraint(equalTo: currentLevelLabel.heightAnchor),
            
            minusLevelButton.trailingAnchor.constraint(equalTo: currentLevelLabel.leadingAnchor, constant: -70),
            minusLevelButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            minusLevelButton.heightAnchor.constraint(equalToConstant: 40),
            minusLevelButton.widthAnchor.constraint(equalTo: minusLevelButton.heightAnchor),
            
            plusLevelButton.leadingAnchor.constraint(equalTo: currentLevelLabel.trailingAnchor, constant: 70),
            plusLevelButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            plusLevelButton.heightAnchor.constraint(equalToConstant: 40),
            plusLevelButton.widthAnchor.constraint(equalTo: plusLevelButton.heightAnchor),
        ])
    }
    
    private func setupTarget() {
        minusLevelButton.addTarget(self, action: #selector(minusLevelAction), for: .touchUpInside)
        plusLevelButton.addTarget(self, action: #selector(plusLevelAction), for: .touchUpInside)
    }
    
    private func updateLevel() {
        let levelStr = String(level)
        currentLevelLabel.text = levelStr
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
