//
//  DataViewController.swift
//  Wisdomleaf_Task
//
//  Created by $umit on 15/05/23.
//

import UIKit

class DataViewController: UIViewController {
    
    @IBOutlet weak var tblView: UITableView!
    var page = 1
    var dataArray: [DataModel] = []
    var dataRefreshControl = UIRefreshControl()
    var selectedData = [Int]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Author Data"
        tblView.delegate = self
        tblView.dataSource = self
        tblView.register(UINib(nibName: "DataTableViewCell", bundle: nil), forCellReuseIdentifier: "DataTableViewCell")
        dataRefreshControl.attributedTitle = NSAttributedString(string: "Pull to fetch more data")
        tblView.refreshControl = dataRefreshControl
        dataRefreshControl.addTarget(self, action: #selector(pullToRefreshData(sender:)), for: .valueChanged)
        callDataApi()
    }
    
    @objc func pullToRefreshData(sender: UIRefreshControl){
        page = page + 1
        self.callDataApi()
        dataRefreshControl.endRefreshing()
    }
    
    @IBAction func onClickRefresh(_ sender: UIBarButtonItem) {
        selectedData.removeAll()
        page =  1
        self.callDataApi()
    }
    
}
// MARK: - TableView Delegate/Datasource methods

extension DataViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataTableViewCell", for: indexPath) as! DataTableViewCell
        cell.infoData = self.dataArray[indexPath.row]
        cell.selectionStyle = .none
        if self.selectedData.contains(indexPath.row){
            cell.checkBoxBtn.setImage(UIImage(named: "tick"), for: .normal)
        }else{
            cell.checkBoxBtn.setImage(UIImage(named: "stop"), for: .normal)
        }
        cell.checkBoxBtn.tag = indexPath.row
        cell.checkBoxBtn.addTarget(self, action: #selector(desc(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataTableViewCell", for: indexPath) as! DataTableViewCell
        var dt = self.dataArray[indexPath.row]
        
        if self.selectedData.contains(indexPath.row){
            let alert = UIAlertController(title: "Description", message: dt.downloadURL, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }else{
            let alert = UIAlertController(title: "Alert", message: "Please select checkbox to view description", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func desc(sender: UIButton){
        let buttonTag = sender.tag
        if selectedData.contains(buttonTag){
            self.selectedData.remove(at: buttonTag)
        }else{
            self.selectedData.append(buttonTag)
        }
        self.tblView.reloadData()
    }
}
// MARK: - Webservice methods
extension DataViewController{
    func callDataApi(){
        let baseUrl = "list?page=\(page)&limit=10"
        showActivityIndicator()
        callAPI(apiname: baseUrl,
                params: nil,
                viewController : self,
                success: {(response) in
            print("Response:- \(response)")
            if response.count != 0{
                self.dataArray =  DataModel.array(jsonObject: response)
                self.tblView.reloadData()
            }
            else {
                showAlertMessage(vc: self, title: nil, message: "Data not found", actionTitle: "Ok", handler: nil)
            }
            hideActivityIndicator()
        })
    }
}
