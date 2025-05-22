


import '../../../const/chat_const.dart';

class UserModel {
   String? id;
   String? name;
   String? email;
   String? image;
   String? pushToken;
   String? about;
   String? time;
   bool? online;
   String? lastActivated;
   String? Mobilephone;
   bool? isDoctor;
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.image,
    required this.pushToken,
    required this.about,
    required this.time,
    required this.online,
    required this.lastActivated,
    required this.Mobilephone,
    required this.isDoctor,

  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json[kId] ?? '',
      name : json[kName],
      email : json[kEmail],
      image : json[kImage],
      pushToken : json[kToken],
      about : json[kAbout],
      time : json[kCreateAt].toString(),
      online : json[kOnline],
      lastActivated : json[kLastActivated].toString(),
      Mobilephone : json[kPhone],
      isDoctor : json[kIsDoctor],

    );
  }
  Map<String, dynamic> toJson()
  {
    return {
      kId : id,
      kName : name,
      kEmail : email,
      kImage : image,
      kToken : pushToken,
      kAbout : about,
      kCreateAt : time,
      kOnline : online,
      kLastActivated : lastActivated,
      kPhone:Mobilephone,
      kIsDoctor : isDoctor,
    };
  }
}
