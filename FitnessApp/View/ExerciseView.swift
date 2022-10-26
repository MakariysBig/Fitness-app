import UIKit
import Then
import SnapKit

final class ExerciseView: UIView {
    
    //MARK: - Internal properties
    
    let gifImage = UIImageView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        $0.backgroundColor = .clear
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 20
    }
    
    let timerLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .center
        $0.textColor = .yellowCustomColor
        $0.font = UIFont.systemFont(ofSize: 50, weight: .heavy)
    }
    
    lazy var startButton = UIButton().then {
        $0.setTitle("Start Exercise", for: .normal)
        $0.setTitleColor(.yellowCustomColor, for: .normal)
        $0.layer.cornerRadius = gifImage.layer.cornerRadius
        $0.backgroundColor = .blueCustomColor
        $0.backgroundColor = .lightGreenCustomColor
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
    
    func setup() {
        backgroundColor = .greenCustomColor
        addSubview(gifImage)
        addSubview(startButton)
        addSubview(timerLabel)
        updateConstraintsIfNeeded()
    }
    
    //MARK: - Override methodes
    
    override func updateConstraints() {
        super.updateConstraints()

        gifImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
            $0.height.equalToSuperview().multipliedBy(0.55)
            $0.width.equalToSuperview().multipliedBy(0.9)
        }

        startButton.snp.makeConstraints {
            $0.leading.equalTo(gifImage.snp.leading)
            $0.trailing.equalTo(gifImage.snp.trailing)
            $0.top.equalTo(gifImage.snp.bottom).offset(25)
            $0.height.equalTo(40)
        }

        timerLabel.snp.makeConstraints {
            $0.leading.equalTo(startButton.snp.leading)
            $0.trailing.equalTo(startButton.snp.trailing)
            $0.top.equalTo(startButton.snp.bottom).offset(25)
            $0.height.equalTo(100)
        }
    }
}
