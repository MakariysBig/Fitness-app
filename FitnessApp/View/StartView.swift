import UIKit
import Then
import SnapKit

final class StartView: UIView {
    
    //MARK: - Internal method

    let startButton = UIButton().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("Start daily workout", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .lightGreenCustomColor
        $0.layer.cornerRadius = 25
    }
    
    let shareButton = UIButton().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle(" Share", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        let image = UIImage(systemName: "square.and.arrow.up")?.withTintColor(.yellowCustomColor, renderingMode: .alwaysOriginal)
        $0.setImage(image, for: .normal)
        $0.backgroundColor = .lightGreenCustomColor
        $0.layer.cornerRadius = 20
    }
    
    let rateUsButton = UIButton().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle(" Rate us", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        let image = UIImage(systemName: "hand.thumbsup")?.withTintColor(.yellowCustomColor, renderingMode: .alwaysOriginal)
        $0.setImage(image, for: .normal)
        $0.backgroundColor = .lightGreenCustomColor
        $0.layer.cornerRadius = 20
    }
    
    let feedbackButton = UIButton().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("Feedback", for: .normal)
        $0.setTitleColor(.yellowCustomColor, for: .normal)
    }
    
    let privacyButton = UIButton().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("Privacy Policy", for: .normal)
        $0.setTitleColor(.yellowCustomColor, for: .normal)
    }
    
    //MARK: - Initialaize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    //MARK: - Private method
    
    private func setup() {
        backgroundColor = .systemBackground
        addSubview(startButton)
        addSubview(rateUsButton)
        addSubview(shareButton)
        addSubview(feedbackButton)
        addSubview(privacyButton)
        setNeedsUpdateConstraints()
    }
    
    //MARK: - Override Method
    
    override func updateConstraints() {
        super.updateConstraints()
        
        startButton.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(30)
            $0.leading.equalTo(shareButton.snp.leading)
            $0.trailing.equalTo(rateUsButton.snp.trailing)
            $0.height.equalTo(50)
        }
        
        shareButton.snp.makeConstraints {
            $0.top.equalTo(startButton.snp.bottom).offset(15)
            $0.centerX.equalToSuperview().offset(-100)
            $0.width.equalTo(self.frame.width / 2.7)
            $0.height.equalTo(40)
        }
        
        rateUsButton.snp.makeConstraints {
            $0.top.equalTo(startButton.snp.bottom).offset(15)
            $0.centerX.equalToSuperview().offset(100)
            $0.width.equalTo(self.frame.width / 2.7)
            $0.height.equalTo(40)
        }
        
        feedbackButton.snp.makeConstraints {
            $0.bottom.equalTo(privacyButton.snp.top).offset(-5)
            $0.centerX.equalToSuperview()
        }
        
        privacyButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            $0.centerX.equalToSuperview()
        }
    }
}

