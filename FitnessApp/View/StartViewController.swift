import UIKit
import StoreKit
import MessageUI

final class StartViewController: UIViewController {
    
    //MARK: - Private propertie
    
    private let userDefaults = UserDefaults.standard
    
    private var rootView: StartView {
        self.view as! StartView
    }
    
    //MARK: - Lifecycle
    
    override func loadView() {
        self.view = StartView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLevel()
        setup()
    }
    
    //MARK: - Private method
    
    private func setupLevel() {
        var level = userDefaults.integer(forKey: "userLevel")
        
        if level == 0 {
            level = 1
            userDefaults.set(level, forKey: "userLevel")
        }
    }
    
    private func setup() {
        view.backgroundColor = .greenCustomColor
        rootView.startButton.addTarget(self,
                                       action: #selector(toExerciseScreen),
                                       for: .primaryActionTriggered)
        rootView.rateUsButton.addTarget(self,
                                        action: #selector(rateButtonTapped),
                                        for: .primaryActionTriggered)
        rootView.feedbackButton.addTarget(self, action:
                                            #selector(feedbackButtonTapped),
                                          for: .primaryActionTriggered)
        rootView.shareButton.addTarget(self,
                                       action: #selector(shareButtonTapped),
                                       for: .primaryActionTriggered)
        rootView.privacyButton.addTarget(self,
                                         action: #selector(privacyButtonTapped),
                                         for: .primaryActionTriggered)
    }
    
    //MARK: - Private action
    
    @objc private func privacyButtonTapped() {
//        guard let url = URL(string: "https://pages.flycricket.io/winpin/privacy.html") else { return }
//        let vc = WebViewController(url: url)
//        present(vc, animated: true)
    }
    
    @objc private func toExerciseScreen() {
        let vc = UINavigationController(rootViewController: ExerciseViewController())
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @objc private func shareButtonTapped() {
        guard let url = URL(string: "") else { return }
        let shareVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        present(shareVC, animated: true)
    }
    
    @objc private func rateButtonTapped() {
        guard let scene = rootView.window?.windowScene else { return }
        SKStoreReviewController.requestReview(in: scene)
    }
    
    @objc private func feedbackButtonTapped() {
        if MFMailComposeViewController.canSendMail() {
            let vc = MFMailComposeViewController()
            vc.mailComposeDelegate = self
            vc.setSubject("Contact us")
            vc.setToRecipients([""])
            present(vc, animated: true)
        } else {
            let alert = UIAlertController(title: "Please, write us!", message: "", preferredStyle: .alert)
            let actionCopy = UIAlertAction(title: "Copy", style: .default) { _ in
                UIPasteboard.general.string = ""
            }
            alert.addAction(actionCopy)
            self.present(alert, animated: true, completion: nil)
        }
    }
}

