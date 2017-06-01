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

// MARK: - UITextViewDelegate
extension MemoViewController: UITextViewDelegate {

    func textViewDidEndEditing(_ textView: UITextView) {

        guard !textView.text.isEmpty else { return }

        if let memo = memo {
            let model = memo
            model.memo = textView.text
            MemoDao.update(model: model)
        } else {
            MemoDao.add(memo: textView.text)
        }
    }
}

// MARK: - private
private extension MemoViewController {

    // MARK: - setup
    func setup() {
        setupTextView()
        setupDoneButton()
        addNotification()
    }

    func setupTextView() {
        textView.text = memo?.memo
        textView.becomeFirstResponder()
    }

    func setupDoneButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "MEMO_DONE".localized(),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(done))
    }

    @objc func done() {
        view.endEditing(true)
        navigationController?.popViewController(animated: true)
    }

    // MARK: - キーボード関連
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
}
