//
//  CompanyListViewController.swift
//  TestCompanyCard
//
//  Created by Kateryna Kozlova on 13/06/2019.
//  Copyright © 2019 Kateryna Kozlova. All rights reserved.
//

import UIKit

var myIndex = 0

class CompanyListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return companyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell()
        cell.textLabel?.text = companyList[indexPath.row].name
        return cell
    }
    
    let companyListTableView = UITableView()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        companyListTableView.delegate = self
        companyListTableView.dataSource = self
        setupCompanyListTableView()
        Request.getCompanyList(completion: { success in
            if success
            {
                self.companyListTableView.reloadData()
            }
        })
    }
    
    private func setupCompanyListTableView()
    {
        view.addSubview(companyListTableView)
        companyListTableView.translatesAutoresizingMaskIntoConstraints = false
        companyListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        companyListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        companyListTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        companyListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let nextScreen = CompanyCardViewController()
        myIndex = indexPath.row+1
        print(myIndex)
        Request.getCompanyDescription(id: myIndex, completion: { success in
            if success
            {
                self.navigationController?.pushViewController(nextScreen, animated: true)
            }
            else
            {
                let alert = UIAlertController(title: "Ошибка сервера", message: "Не удалось выполнить запрос", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        })
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
