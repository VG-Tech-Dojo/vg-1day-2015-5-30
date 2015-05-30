//
//  PostViewController.swift
//  My1DayApp
//
//  Created by 清 貴幸 on 2015/05/04.
//  Copyright (c) 2015年 VOYAGE GROUP, inc. All rights reserved.
//

import UIKit

protocol PostViewControllerDelagate : NSObjectProtocol {
    func postViewController(viewController : PostViewController, didTouchUpCloseButton: AnyObject)
}

class PostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var myImagePicker: UIImagePickerController!
    
    @IBOutlet weak private var messageTextView: UITextView!
    weak var delegate: PostViewControllerDelagate?
    // Mission1-2 Storyboard から UITextField のインスタンス変数を追加
    @IBOutlet weak private var userNameTextView: UITextField!
    
    @IBOutlet weak var myImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.messageTextView.becomeFirstResponder()
    }
    
    // MARK: - IBAction
    @IBAction func didTouchUpSelectImageButton(sender: AnyObject) {
        self.pickImageFromLibrary()
    }
    
    // ライブラリから写真を選択する
    func pickImageFromLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            let controller = UIImagePickerController()
            controller.delegate = self
            controller.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            self.presentViewController(controller, animated: true, completion: nil)
        }
    }
    
    // 写真を選択した時に呼ばれる
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if info[UIImagePickerControllerOriginalImage] != nil {
            let image = info[UIImagePickerControllerOriginalImage] as! UIImage
            myImageView.image = image
        }
        picker.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func didTouchUpCloseButton(sender: AnyObject) {
        self.messageTextView.resignFirstResponder()
        self.delegate?.postViewController(self, didTouchUpCloseButton: sender)
    }
    
    @IBAction func didTouchUpSendButton(sender: AnyObject) {
        self.messageTextView.resignFirstResponder()
        
        let message: String = self.messageTextView.text ?? ""
        // Mission1-2 UITextField のインスタンス変数から値を取得
        let userName: String = self.userNameTextView.text ?? ""
        let image: UIImage? = self.myImageView.image
        
        var imgData: NSData = NSData(data: UIImageJPEGRepresentation(image, 0.5))
        imgData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
        
        // Mission1-2 posetMessage の第2引数に 任意の値を渡す
        APIRequest.postMessage(message, username: userName, image: imgData) {
            [weak self] (data, response, error) -> Void in
            
            self?.delegate?.postViewController(self!, didTouchUpCloseButton: sender)
            
            if error != nil {
                // TODO: エラー処理
                println(error)
                return
            }
            
            var decodeError: NSError?
            let responseBody: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.allZeros, error: &decodeError)
            if decodeError != nil{
                println(decodeError)
                return
            }
        }
        
    }
}
