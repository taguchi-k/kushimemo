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
    fileprivate let dataSource = MemoListProvider()
    fileprivate var alert: UIAlertController!

    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        dataSource.add(memoModels: MemoDao.findAll())
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

        guard !isEditing else { return }

        let memoModel = dataSource.memo(index: indexPath.row)
        let vc = MemoViewController.create(memoModel: memoModel)
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - MemoListProviderDelegate
extension MemoListViewController: MemoListProviderDelegate {

    func didDeleteRows() {
        reloadData()
    }
}

// MARK: - MemoAlertHelperDelegate
extension MemoListViewController: MemoAlertHelperDelegate {

    func deleteAll() {
        MemoDao.deleteAll()
        dataSource.add(memoModels: [])
        reloadData()
        isEditing = false
    }
}

// MARK: - private
private extension MemoListViewController {

    func setup() {
        navigationItem.rightBarButtonItem = editButtonItem
        tableView.dataSource = dataSource
        dataSource.delegate = self
        tableView.tableFooterView = UIView()
        toggleAddAndDeleteAllButton(editing: isEditing)
    }

    func reloadData() {
        tableView.reloadData()
        updateMemoCount()
    }

    func updateMemoCount() {
        if dataSource.memoModels.isEmpty {
            memoCountLabel.title = "LIST_NODATA".localized()
        } else {
            memoCountLabel.title = String(format: "LIST_COUNT".localized(), dataSource.memoModels.count)
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
        alert = MemoAlertHelper().deleteMemo(delegate: self)
        present(alert, animated: true) { self.alert = nil }
    }
}
