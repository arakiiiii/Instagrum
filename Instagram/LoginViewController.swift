//
//  LoginViewController.swift
//  Instagram
//
//  Created by Akira Kamite on 2018/12/01.
//  Copyright © 2018 araki. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import SVProgressHUD

class LoginViewController: UIViewController {
    
    @IBOutlet weak var mailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var displayNameTextField: UITextField!
    
    
//    ログインボタンをタップした時に呼ばれるメソッド
    @IBAction func handleLoginButton(_ sender: Any) {
        if let address = mailAddressTextField.text, let passord = passwordTextField.text {
            
//        アドレスとパスワード名いずれかでも入力されていない時は何もしない
            if address.isEmpty || passord.isEmpty {
                SVProgressHUD.showError(withStatus: "必要項目を入力してください")
                return
            }
            
//            HUDで処理中を表示
            SVProgressHUD.show()
            
            Auth.auth().signIn(withEmail: address, password: passord) { user, error in
                
                if let error = error {
                    print("DEBUG_PRINT" + error.localizedDescription)
                    SVProgressHUD.showError(withStatus: "サインインに失敗しました")
                    return
                } else {
                    print("DEBUG_PRINT: ログインに成功しました。")
                    
//                    HUDを消す
                    SVProgressHUD.dismiss()
                    
//                    画面を閉じてViewControllerに戻る
                    self.dismiss(animated: true, completion: nil)
                }
                
            }
        
        }
    }
    
//    アカウント作成ボタンをタップしたときに呼ばれるメソッド
    @IBAction func handleCreateAccountButton(_ sender: Any) {
        if let adress = mailAddressTextField.text, let password = passwordTextField.text, let displayName = displayNameTextField.text {
            
//            アドレスとパスワードと表示名いずれかでも入力されていない時は何もしない
            if adress.isEmpty || password.isEmpty || displayName.isEmpty {
                print("DEBUG_PRINT: 何かが空文字です。")
                SVProgressHUD.showError(withStatus: "必要項目を入力してください")
                return
            }
            
//            HUDで処理中を表示
            SVProgressHUD.show()
            
            
//            アドレスとパスワードでユーザー作成。ユーザー作成に成功すると自動的にログインする
            Auth.auth().createUser(withEmail: adress, password: password) { user, error in
                
                if let error = error {
//                    エラーがあったら原因をprintして、returnすることで以降の処理を実行せずに処理を終了する
                    print("DEBUG_PRINT: " + error.localizedDescription)
                    SVProgressHUD.showError(withStatus: "ユーザー登録に失敗しました。")
                    return
                }
                print("DEBUG_PRINT: ユーザー作成に成功しました。")
                
//                表示名を設定する
                let user = Auth.auth().currentUser
                if let user = user {
                    let changeRequest = user.createProfileChangeRequest()
                    changeRequest.displayName = displayName
                    changeRequest.commitChanges { error in
                        if let error = error {
//                            プロフィールの更新でエラーが発生
                            print("DEBUG_PRINT: " + error.localizedDescription)
                            return
                        }
                        print("DEBUG_PRINT: [displayName = \(user.displayName!)の設定に成功しました。]")
                        
//                        HUDを消す
                        SVProgressHUD.dismiss()
                        
//                        画面を閉じてViewControllerに戻る
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
