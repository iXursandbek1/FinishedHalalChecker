//
//  ViewController.swift
//  FinishedHalalChecker
//
//  Created by Mac on 27/12/22.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    //MARK: - Outlets -
    let mainTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray6
        initView()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "camera"),
            style: .done,
            target: self,
            action: #selector(takePhotoItemAct))
    }

    //MARK: - Init View -
    func initView() {
        
        // Hader of the mainTableView
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50))
        
        let searchBar = UISearchBar(frame: headerView.bounds)
        headerView.addSubview(searchBar)
        
        // mainaTableView
        view.addSubview(mainTableView)
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.tableHeaderView = headerView
        mainTableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        mainTableView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc func takePhotoItemAct () {
        
        let vc = TakePicViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
       
        cell.textLabel?.text = "E-Category"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 50
    }
}
