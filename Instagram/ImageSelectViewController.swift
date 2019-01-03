//
//  ImageSelectViewController.swift
//  Instagram
//
//  Created by Akira Kamite on 2018/12/01.
//  Copyright © 2018 araki. All rights reserved.
//

import UIKit
import CLImageEditor

class ImageSelectViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, CLImageEditorDelegate {
    
//    ライブラリボタンが押されたときに呼ばれる
    @IBAction func handleLibraryButton(_ sender: Any) {
//        カメラロールを指定してピッカーを開く
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.sourceType = .photoLibrary
            self.present(pickerController, animated: true, completion: nil)
        }
    }
    
//    カメラボタンを押されたときに呼ばれる
    @IBAction func handleCameraButton(_ sender: Any) {
//        カメラを指定してピッカーを開く
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.sourceType = .camera
            self.present(pickerController, animated: true, completion: nil)
        }
    }
    
//    キャンセルボタンを押した時の呼ばれる
    @IBAction func handleCacelButton(_ sender: Any) {
//        画面を閉じる
        self.dismiss(animated: true, completion: nil)
    }
    
//    写真を撮影/選択したときに呼ばれる
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if info[UIImagePickerControllerOriginalImage] != nil {
//            撮影/選択された画像を取得する
            let image = info[UIImagePickerControllerOriginalImage] as! UIImage
            
//            あとでCLImageEditorライブラリで加工する
            print("DEBUG_PRINT: image = \(image)")
            
//            CLImageEditorにimageを渡して加工画面を起動する
            let editor = CLImageEditor(image: image)!
            editor.delegate = self
            picker.pushViewController(editor, animated: true)
        }
    }
    
//    CLImageEditorで加工が終わったときに呼ばれる
    func imageEditor(_ editor: CLImageEditor!, didFinishEditingWith image: UIImage!) {
//        投稿画面を開く
        let postViewController = self.storyboard?.instantiateViewController(withIdentifier: "Post") as! PostViewController
        postViewController.image = image!
        editor.present(postViewController, animated: true, completion: nil)
    }

    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        画面を閉じる
        picker.dismiss(animated: true, completion: nil)
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
