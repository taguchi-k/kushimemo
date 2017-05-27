//
//  MemoListViewController.swift
//  kushimemo
//
//  Created by Kentaro on 2017/05/27.
//  Copyright © 2017年 Kentao Taguchi. All rights reserved.
//

import UIKit
import STV_Extensions

final class MemoListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet fileprivate weak var toolbar: UIToolbar!
    @IBOutlet fileprivate weak var memoCountLabel: UIBarButtonItem!
    fileprivate let dataSource = MemoListTableViewProvider()

    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        loadMemo()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadMemo()
        reloadData()
    }

    // MARK: - Edit
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
        toggleAddAndDeleteAllButton(editing: editing)
    }
}

// MARK: - UITableViewDelegate
extension MemoListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)

        let memo = dataSource.findMemo(row: indexPath.row)
        let vc = MemoViewController.create(memo: memo)
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - MemoListTableViewProviderDelegate
extension MemoListViewController: MemoListTableViewProviderDelegate {

    func didDeleteRows() {
        reloadData()
    }
}

// MARK: - private
private extension MemoListViewController {

    func setup() {
        navigationItem.rightBarButtonItem = editButtonItem
        tableView.dataSource = dataSource
        dataSource.delegate = self
        tableView.tableFooterView = UIView()
        toggleAddAndDeleteAllButton(editing: false)
    }

    func loadMemo() {
        let memos = MemoDao.findAll().sorted { $0.lastModify > $1.lastModify }
        dataSource.add(memos: memos)
    }

    func reloadData() {
        tableView.reloadData()
        updateMemoCount()
    }

    func updateMemoCount() {

        if dataSource.memos.isEmpty {
            memoCountLabel.title = "LIST_NODATA".localized()
        } else {
            memoCountLabel.title = String(format: "LIST_COUNT".localized(), dataSource.memos.count)
        }
    }

    // MARK: - UIBarButtonItem
    func toggleAddAndDeleteAllButton(editing: Bool) {

        guard var items = toolbar.items else { return }
        let toggleButton: UIBarButtonItem

        if editing {
            toggleButton = UIBarButtonItem(title: "LIST_DELETE_ALL".localized(),
                                           style: .plain,
                                           target: self,
                                           action: #selector(didTapDeleteAllButton))
        } else {
            toggleButton = UIBarButtonItem(title: "LIST_ADD_MEMO".localized(),
                                           style: .plain,
                                           target: self,
                                           action: #selector(didTapAddMemoButton))
        }

        items[0] = toggleButton
        toolbar.setItems(items, animated: true)
    }

    @objc func didTapAddMemoButton() {
        let vc = MemoViewController.create()
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc func didTapDeleteAllButton() {
        showActionSheet()
    }

    func showActionSheet() {

        let cancelAction = UIAlertAction(title: "LIST_CANCEL".localized(), style: .cancel)
        let deleteAllAction = UIAlertAction(title: "LIST_DELETE_ALL".localized(),
                                            style: .destructive) { _ in self.deleteAll() }
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(cancelAction)
        actionSheet.addAction(deleteAllAction)

        present(actionSheet, animated: true)
    }
    
    func deleteAll() {
        MemoDao.deleteAll()
        dataSource.add(memos: [])
        reloadData()
    }
}
