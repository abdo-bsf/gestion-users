//
//  ViewController.swift
//  Gestion Users
//
//  Created by basafou on 8/25/20.
//  Copyright © 2020 basafou. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var ListUsers = [User]()
    
     let UsersTableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        table.showsVerticalScrollIndicator = false
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    let activityView = UIActivityIndicatorView(style: .large)


    override func viewDidLoad() {
        super.viewDidLoad()
        setup_table_view()
        setup_activity_view()
        view.backgroundColor = .white
        self.navigationItem.title = "List Users"
        
        UserModel().get_all_users{(user: [User]) in
            self.ListUsers.append(contentsOf: user)
            self.UsersTableView.reloadData()
            self.activityView.stopAnimating()
            self.UsersTableView.backgroundColor = .white
        }
    }

    func setup_activity_view(){
        activityView.center = self.view.center
        activityView.hidesWhenStopped = true
        self.view.addSubview(activityView)
        activityView.startAnimating()
    }
    
    func setup_table_view(){
        UsersTableView.dataSource = self
        UsersTableView.delegate = self
        self.UsersTableView.rowHeight = 100
        self.view.addSubview(UsersTableView)
        UsersTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        UsersTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 10).isActive = true
        UsersTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        UsersTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -10).isActive = true
        self.UsersTableView.separatorColor = UIColor.clear
        UsersTableView.register(UserCell.self, forCellReuseIdentifier: "cell")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
           return self.ListUsers.count
    }

       // There is just one row in every section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // Make the background color show through
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UsersTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UserCell
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
        cell.name.text = ListUsers[indexPath.section].name
        cell.username.text = ListUsers[indexPath.section].username
        cell.email.text = ListUsers[indexPath.section].email
        
        cell.backgroundColor = UIColor.white
        cell.layer.borderColor = UIColor(red:211/255, green:211/255, blue:211/255, alpha: 1).cgColor
        cell.layer.borderWidth = 1
        cell.clipsToBounds = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newViewController = TacheViewController()
        newViewController.id_user = ListUsers[indexPath.section].id
        //newViewController.title_topics = ListRebrique[indexPath.section].name
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    


}

class UserCell: UITableViewCell {
    
    let name: UILabel = {
        let textview = UILabel()
        textview.text = "Sport"
        textview.textColor = UIColor(named: "Color_general")
        textview.lineBreakMode = NSLineBreakMode.byWordWrapping
        textview.isUserInteractionEnabled = true
        textview.numberOfLines = 2
        textview.translatesAutoresizingMaskIntoConstraints = false
        return textview
    }()
    
    let username:UILabel = {
        let textview = UILabel()
        textview.text = ""
        textview.font = UIFont(name: "Arial", size: 16)
        textview.textColor = UIColor(named: "url_source")
        textview.lineBreakMode = NSLineBreakMode.byWordWrapping
        textview.isUserInteractionEnabled = true
        textview.numberOfLines = 2
        textview.translatesAutoresizingMaskIntoConstraints = false
        return textview
    }()
    
    let email:UILabel = {
        let textview = UILabel()
        textview.text = ""
        textview.font = UIFont(name: "Arial", size: 16)
        textview.textColor = UIColor(named: "url_source")
        textview.lineBreakMode = NSLineBreakMode.byWordWrapping
        textview.isUserInteractionEnabled = true
        textview.numberOfLines = 2
        textview.translatesAutoresizingMaskIntoConstraints = false
        return textview
    }()
    
    let view_cell:UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let separator:UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func setup_element(){
        addSubview(view_cell)
        view_cell.addSubview(name)
        view_cell.addSubview(username)
        view_cell.addSubview(email)
        
        view_cell.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 10).isActive = true
        view_cell.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -10).isActive = true
        view_cell.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        name.topAnchor.constraint(equalTo: view_cell.topAnchor,constant: 10).isActive = true
        name.leadingAnchor.constraint(equalTo: view_cell.leadingAnchor,constant: 6).isActive = true
        
        username.topAnchor.constraint(equalTo: name.bottomAnchor,constant: 2).isActive = true
        username.leadingAnchor.constraint(equalTo: name.leadingAnchor).isActive = true
        username.trailingAnchor.constraint(equalTo: view_cell.trailingAnchor,constant: -10).isActive = true
        
        email.topAnchor.constraint(equalTo: username.bottomAnchor,constant: 2).isActive = true
        email.leadingAnchor.constraint(equalTo: name.leadingAnchor).isActive = true
        email.trailingAnchor.constraint(equalTo: view_cell.trailingAnchor,constant: -10).isActive = true
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup_element()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
