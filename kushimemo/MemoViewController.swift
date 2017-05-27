//
//  MemoViewController.swift
//  kushimemo
//
//  Created by Kentaro on 2017/05/27.
//  Copyright © 2017年 Kentao Taguchi. All rights reserved.
//

import UIKit
import STV_Extensions

final class MemoViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textViewBottom: NSLayoutConstraint!

    fileprivate var memo: MemoModel?

    // MARK: - Factory
    static func create(memo: MemoModel? = nil) -> MemoViewController {

        if let vc = UIStoryboard.viewController(storyboardName: MemoViewController.className,
                                                identifier: MemoViewController.className) as? MemoViewController {
            vc.memo = memo
            return vc
        }
        fatalError("unwap MemoViewController")
    }

    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - private
private extension MemoViewController {

    var isNew: Bool {
        return memo == nil
    }

    // MARK: - setup
    func setup() {
        setupTextView()
        setupDoneButton()
        addNotification()
    }

    func setupTextView() {
        if let memo = memo {
            textView.text = memo.title + Constants.lineFeed + memo.text
        }

        textView.becomeFirstResponder()
    }

    func setupDoneButton() {

        let doneButton = UIBarButtonItem(title: "MEMO_DONE".localized(),
                                         style: .plain,
                                         target: self,
                                         action: #selector(done))
        navigationItem.rightBarButtonItem = doneButton
    }

    @objc func done() {
        view.endEditing(true)
        navigationController?.popViewController(animated: true)
    }

    func addNotification() {

        let nc = NotificationCenter.default

        // キーボード表示
        nc.addObserver(self,
                       selector: #selector(keyboardWillShow(notification:)),
                       name: .UIKeyboardWillShow,
                       object: nil)

        // キーボード変化
        nc.addObserver(self,
                       selector: #selector(keyboardWillChangeFrame(notification:)),
                       name: .UIKeyboardWillChangeFrame,
                       object: nil)

        // キーボード非表示
        nc.addObserver(self,
                       selector: #selector(keyboardWillHide),
                       name: .UIKeyboardWillHide,
                       object: nil)
    }

    @objc func keyboardWillShow(notification: Notification) {
        changeTextViewBottom(notification: notification)
    }

    @objc func keyboardWillChangeFrame(notification: Notification) {
        changeTextViewBottom(notification: notification)
    }

    @objc func keyboardWillHide() {
        textViewBottom.constant = 0
    }

    func changeTextViewBottom(notification: Notification) {

        guard let rect = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        textViewBottom.constant = rect.height
    }

    // MARK: - メモ登録
    func createMemo(from text: String) -> MemoModel {

        let lines = text.lines

        let model = MemoModel()
        model.title = lines.first ?? ""
        model.lastModify = Date()
        model.text = lines.dropFirst().joined(separator: Constants.lineFeed)

        return model
    }
}

// MARK: - UITextViewDelegate
extension MemoViewController: UITextViewDelegate {

    func textViewDidEndEditing(_ textView: UITextView) {
        guard !textView.text.isEmpty else { return }

        let model = createMemo(from: textView.text)
        
        if isNew {
            MemoDao.add(model: model)
        } else {
            MemoDao.update(model: model)
        }
    }
}
