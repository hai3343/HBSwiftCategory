//
//  HBHTTP.swift
//  HBSwiftCategory
//
//  Created by 胡海兵 on 2021/9/28.
//

import Foundation

enum HttpMethod {
    case GET,
         POST
}
//在http中定义类方法来做请求，方便使用
class HBHTTP {
    
              func request(method:HttpMethod, url:String,params:[String:Any]=[:],complete: @escaping(_result:String)->Void,error:@escaping(_error:Error?)->Void){
        
                        var url = url
        
                        //处理参数为了方便这里抽取里一个方法来处理参数
        
                let param =self.parserParams(params: params)
        
                        //设置get请求参数
        
                          if method == .GET&&param !=""{
            
                                  if url.contains("?"){
                
                                              url.append("&\(param)")
                
                                        }else{
                    
                                                url.append("?\(param)")
                    
                                            }
            
                            }
        
                // 注意这里需要将含有中文的参数进行编码处理，否则创建URL 对象就会返回nil。
        
                    url = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
                        let_url =URL(string: url)!
        
                        let request =NSMutableURLRequest(url: _url)
        
                  //设置超时时间
        
                        request.timeoutInterval=50
        
                      //设置请求方式
        
                        request.httpMethod= method == .GET ? "GET" : "POST"
        
                          //设置post请求参数
        
                        if method == .POST&& param !=""{
            
                                    request.httpBody=param.data(using: .utf8)
            
                            }
        
                        let session =URLSession.shared
        
                        let httpTask = session.dataTask(with: request as URLRequest) { (data,response ,err ) in
            
                                    //在主线程中回调方便在界面处理数据逻辑
            
                                    OperationQueue.main.addOperation {
                
                                        if err !=nil{
                    
                                            //错误回调
                    
                                                    error(err)
                    
                                                return
                    
                                            }
                
                                    //请求成功将结果返回
                
                                        complete(String(data: data!, encoding:String.Encoding.utf8)!)
                
                                      }
            
                            }
        
                        //启动任务
        
                        httpTask.resume()
        
                }
    
            //将字典转换成网络请求的参数字符串
    
            private class func parserParams(params:[String:Any])->String{
        
                        var newStr=""
        
                        for param in params{
            
                              newStr.append("\(param.key)=\(param.value)&")
            
                            }
        
                            return newStr
        
                }
    
}

