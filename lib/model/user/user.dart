class User {
  String? email;
  String? firstName;
  String? lastName;
  String? mobile;
  String? avatar;

  User({
    this.email,
    this.firstName,
    this.lastName,
    this.mobile,
    this.avatar,
  });

  User.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    firstName = json['fName'];
    lastName = json['lName'];
    mobile = json['mobile'];
    avatar = json['userPictureUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['mobile'] = mobile;
    data['userPictureUrl'] = avatar;
    return data;
  }

  @override
  String toString() {
    return 'User{email: $email,  '
        'firstName: $firstName, lastName: $lastName, mobile: $mobile, '
        'avatar: $avatar, ';
  }
}
