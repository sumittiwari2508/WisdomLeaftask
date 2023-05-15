//
//  AppUtility.swift
//  Wisdomleaf_Task
//
//  Created by $umit on 15/05/23.
//

import Foundation
import UIKit
import SVProgressHUD
import AVFoundation

// MARK: - Alert
func showAlertMessage(vc: UIViewController, title: String?, message: String?, actionTitle: String?, handler:((UIAlertAction)->Void)?) -> Void {
    let alertCtrl = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    let alertAction = UIAlertAction(title: actionTitle, style: .cancel, handler: handler)
    
    alertCtrl.addAction(alertAction)
    vc.present(alertCtrl, animated: true, completion: nil)
}

// MARK: - Activity Indicator

func showActivityIndicator(message: String? = "Please wait...") {
    DispatchQueue.main.async {
        //SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.dark)
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
        SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.native)
        if message != nil {
            SVProgressHUD.show(withStatus: message!)
        } else {
            SVProgressHUD.show()
        }
    }
}

func hideActivityIndicator() {
    DispatchQueue.main.async { SVProgressHUD.dismiss() }
}
