import UIKit
import SnapKit
import Then

final class LevelView: UIView {
    
    //MARK: - Private properties
    
    private let levelLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        $0.textAlignment = .center
        $0.text = "LEVEL"
        $0.textColor = .yellowCustomColor
    }
    
    //MARK: - Internal properties

    let currentLevelLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        $0.textAlignment = .center
        $0.text = "1"
        $0.textColor = .yellowCustomColor
    }
    
    let plusLevelButton = UIButton().then {
        $0.setBackgroundImage(UIImage(systemName: "plus.circle"), for: .normal)
        $0.tintColor = .yellowCustomColor
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let minusLevelButton = UIButton().then {
        $0.setBackgroundImage(UIImage(systemName: "minus.circle"), for: .normal)
        $0.tintColor = .yellowCustomColor
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    //MARK: - Initialize

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private methodes
    
    private func setup() {
        backgroundColor = .greenCustomColor
        addSubview(minusLevelButton)
        addSubview(currentLevelLabel)
        addSubview(plusLevelButton)
        addSubview(levelLabel)
        setNeedsUpdateConstraints()
    }
    
    //MARK: - Override properties
    
    override func updateConstraints() {
        super.updateConstraints()
        
        levelLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(currentLevelLabel.snp.top).offset(-50)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        currentLevelLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.height.width.equalTo(50)
        }
        
        minusLevelButton.snp.makeConstraints {
            $0.trailing.equalTo(currentLevelLabel.snp.leading).offset(-70)
            $0.centerY.equalToSuperview()
            $0.height.width.equalTo(40)
        }
        
        plusLevelButton.snp.makeConstraints {
            $0.leading.equalTo(currentLevelLabel.snp.trailing).offset(70)
            $0.centerY.equalToSuperview()
            $0.height.width.equalTo(40)
        }
    }
}
