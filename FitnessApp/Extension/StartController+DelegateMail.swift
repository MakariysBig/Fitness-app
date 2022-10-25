import UIKit
import MessageUI

extension StartViewController: MFMailComposeViewControllerDelegate {
    @objc(mailComposeController:didFinishWithResult:error:)
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: NSError?) {
        controller.dismiss(animated: true)
    }
}
