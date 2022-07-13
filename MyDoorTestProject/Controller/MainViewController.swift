//
//  ViewController.swift
//  MyDoorTestProject
//
//  Created by Алина Бондарчук on 06.07.2022.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    private let stackView = WelcomeStackVew()
    private let tableView = UITableView()
    
    private let apiCaller = APICaller()
    
    var doorCell: DoorTableCell?
    
    var doors = [Door]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(stackView)
        configureNavigationBarItem()
        configureTableView()
        
        apiCaller.fetchData { [weak self] result in
            switch result {
            case .success(let data):
                self?.doors.append(contentsOf: data)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(_):
                break
            }
        }
    }
    
    private func configureNavigationBarItem () {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "interQR")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: nil)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Setting")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: nil)
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.register(DoorTableCell.self, forCellReuseIdentifier: DoorTableCell.id)
        tableView.register(TableHeader.self, forHeaderFooterViewReuseIdentifier: TableHeader.id)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp_bottomMargin).offset(30)
            make.left.right.equalTo(view).inset(16)
            make.bottom.equalTo(view).offset(0)
        }
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return doors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DoorTableCell.id, for: indexPath) as? DoorTableCell else { return UITableViewCell() }
        
        let door = doors[indexPath.row]
        
        cell.configureCell(title: door.title, location: door.location)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let door = tableView.cellForRow(at: indexPath) as! DoorTableCell
        updateDisplay(cell: door)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: TableHeader.id)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height / 6
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension MainViewController: DoorCellDelegate {
    
    func updateDisplay(cell: DoorTableCell) {
        if doorCell != nil {
            doorCell?.changeStatusAction()
        } else {
            doorCell = cell
            doorCell?.changeStatusAction()
            doorCell = nil
        }
    }
    
    func cellTapped(cell: DoorTableCell) {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}
