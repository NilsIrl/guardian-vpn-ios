//
//  SettingsViewController
//  FirefoxPrivateNetworkVPN
//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at https://mozilla.org/MPL/2.0/.
//
//  Copyright © 2019 Mozilla Corporation.
//

import UIKit

class SettingsViewController: UIViewController, Navigating {
    // MARK: - Properties
    static var navigableItem: NavigableItem = .settings

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var signOutButton: UIButton!

    private var dataSource: SettingsDataSource?

    // MARK: - Initialization
    init() {
        super.init(nibName: String(describing: Self.self), bundle: nil)
        setupTabBar()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setStrings()

        dataSource = SettingsDataSource(with: tableView)
        tableView.tableFooterView = UIView()
        tableView.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }

    // MARK: - IBActions
    @IBAction func signOut() {
        DependencyFactory.sharedFactory.tunnelManager.stop()
        DependencyFactory.sharedFactory.accountManager.logout { [weak self] _ in
            self?.navigate(to: .landing)
        }
    }

    // MARK: - Setup
    private func setupTabBar() {
        let tag: TabTag = .settings
        tabBarItem = UITabBarItem(title: LocalizedString.settingsTabName.value, image: UIImage(named: "tab_settings"), tag: tag)
    }

    private func setupNavigationBar() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        navigationItem.backBarButtonItem = nil
    }

    private func setStrings() {
        signOutButton.setTitle(LocalizedString.settingsSignOut.value, for: .normal)
    }
}