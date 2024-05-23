import 'package:cloud_firestore/cloud_firestore.dart';
CustomersModel? customersmodel;
class CustomersModel{
  String? userName;
  // DocumentReference? ref;
  // String? uid;
  DateTime? createDate;
  String? contactNumber;

  CustomersModel.fromJson(Map<String,dynamic>Json){
    userName =Json['userName']??'';
    userName =Json['contactNumber']??'';
    // uid =Json['uid']??'';
    // ref =Json['ref'];
    createDate=Json["createDate"]==null?DateTime.now():Json["createDate"].toDate();
  }
  CustomersModel({
    required this.userName,
    // this.ref,
    //  this.uid,
    required this.createDate,
    required this.contactNumber,
  });
  Map<String,dynamic>toJson(){
    final Map<String,dynamic>data=<String,dynamic>{};
    data['userName']=userName;
    data['contactNumber']=contactNumber;
    data['createDate']=createDate;
    // data['uid']=uid;
    // data['ref']=ref;
    return data;

  }
  CustomersModel copyWith(
      {
        String? userName,
        String ? contactNumber,
        // String? uid,
        // DocumentReference? ref,
        DateTime? createDate,
      }
      )
  {
    return CustomersModel(
        userName:userName?? this.userName,
      contactNumber:contactNumber?? this.contactNumber,
        createDate:createDate?? this.createDate,
        // ref: ref?? this.ref,
        // uid: uid?? this.uid
    );
  }
}