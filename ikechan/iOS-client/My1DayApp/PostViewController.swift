//
//  PostViewController.swift
//  My1DayApp
//
//  Created by 清 貴幸 on 2015/05/04.
//  Copyright (c) 2015年 VOYAGE GROUP, inc. All rights reserved.
//

import UIKit

protocol PostViewControllerDelagate : NSObjectProtocol{
    func postViewController(viewController : PostViewController, didTouchUpCloseButton: AnyObject)
}

class PostViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    @IBOutlet weak private var messageTextView: UITextView!
    weak var delegate: PostViewControllerDelagate?
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var zokuseiPicker: UIPickerView!
    
    private let myValues: NSArray = ["honoo","mizu","kusa"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.messageTextView.becomeFirstResponder()
        self.zokuseiPicker.delegate = self
        self.zokuseiPicker.dataSource = self
        self.messageTextView.text = "honoo"
        self.messageTextView.hidden = true
    }
    
    // MARK: - IBAction
    
    @IBAction func didTouchUpCloseButton(sender: AnyObject) {
        self.messageTextView.resignFirstResponder()
        self.delegate?.postViewController(self, didTouchUpCloseButton: sender)
    }
    
    @IBAction func didTouchUpSendButton(sender: AnyObject) {
        self.messageTextView.resignFirstResponder()
        
        let message: String = self.messageTextView.text ?? ""
        // Mission1-2 UITextField のインスタンス変数から値を取得
        let name: String = self.nameTextField.text ?? ""
        
        // Mission1-2 posetMessage の第2引数に 任意の値を渡す
        APIRequest.postMessage(message, username: name) {
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
    /*
    pickerに表示する列数を返すデータソースメソッド.
    (実装必須)
    */
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    /*
    pickerに表示する行数を返すデータソースメソッド.
    (実装必須)
    */
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return myValues.count
    }
    
    /*
    pickerに表示する値を返すデリゲートメソッド.
    */
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String {
        return myValues[row] as! String
    }
    
    /*
    pickerが選択された際に呼ばれるデリゲートメソッド.
    */
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        println("row: \(row)")
        println("value: \(myValues[row])")
        self.messageTextView.text = myValues[row] as! String
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
