//
//  Request.swift
//  TestCompanyCard
//
//  Created by Kateryna Kozlova on 13/06/2019.
//  Copyright © 2019 Kateryna Kozlova. All rights reserved.
//

import Foundation
import Alamofire

struct Company
{
    var id = ""
    var name = ""
}

struct CompanyDescription
{
    var id = ""
    var name = ""
    var description = ""
}

var companyList: [Company] = [Company()]
var companyDescription = CompanyDescription()

class Request
{
    static func getCompanyList(completion: @escaping (_ success: Bool) -> ())
    {
        var result: Bool?
        AF.request("http://megakohz.bget.ru/test.php", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil, interceptor: nil).responseJSON(completionHandler:
            { response in
                switch response.result
                {
                case .success(let JSON):
                    let answerArray = JSON as! NSArray
                    companyList = []
                    for i in 0..<answerArray.count
                    {
                        companyList.append(Company())
                        let company = answerArray.object(at: i) as! NSDictionary
                        companyList[i].id = company.value(forKey: "id") as! String
                        companyList[i].name = company.value(forKey: "name") as! String
                    }
                    result = true
                case .failure(let error):
                    print(error)
                    result = false
                }
                completion(result!)
            })
    }
    
    static func getCompanyDescription(id: Int, completion: @escaping (_ success: Bool) -> ())
    {
        var result: Bool?
        AF.request("http://megakohz.bget.ru/test.php?id=\(id)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil, interceptor: nil).responseJSON(completionHandler:
            { response in
                switch response.result
                {
                case .success(let JSON):
                    print(JSON)
                    let answerArray = JSON as! NSArray
                    let answer = answerArray[0] as! NSDictionary
                    companyDescription.id = answer.object(forKey: "id") as! String
                    companyDescription.name = answer.object(forKey: "name") as! String
                    companyDescription.description = answer.object(forKey: "description") as! String
                    result = true
                case .failure(let error):
                    print(error)
                    result = false
                }
                completion(result!)
        })
    }
}
