class DummyDataModel {
  int? id;
  String? imageUrl;
  String? firstName;
  String? lastName;
  String? email;
  String? contactNumber;
  int? age;
  String? dob;
  double? salary;
  String? address;

  DummyDataModel(
      {this.id,
        this.imageUrl,
        this.firstName,
        this.lastName,
        this.email,
        this.contactNumber,
        this.age,
        this.dob,
        this.salary,
        this.address});

  DummyDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageUrl = json['imageUrl'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    contactNumber = json['contactNumber'];
    age = json['age'];
    dob = json['dob'];
    salary = json['salary'];
    address = json['address'];
  }
}
