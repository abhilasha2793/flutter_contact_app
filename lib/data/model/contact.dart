/// A data model class for Contact
class Contact {
  int? id;
  String name;
  String mobile;
  String? landLine;
  String? imageUrl;
  bool favorite = false;

  Contact(
      {required this.id,
      required this.name,
      required this.mobile,
      this.landLine,
      this.imageUrl,
      this.favorite = false});

  factory Contact.fromJson(Map<String, dynamic> data) {
    return Contact(
      id: data['id'],
      name: data['name'],
      mobile: data['mobile'],
      landLine: data['landLine'],
      favorite: data['favorite'],
      imageUrl: data['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['landLine'] = this.landLine;
    data['favorite'] = this.favorite;
    data['imageUrl']=this.imageUrl;
    return data;
  }

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, Object?> toMap() {
    return {
      'id': id,
      'mobile': mobile,
      'name': name,
      'landLine': landLine,
      'favorite': favorite,
      'imageUrl':imageUrl,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Contact{id: $id, name: $name, mobile: $mobile, landLine: $landLine , imageUrl:$imageUrl} , isFavourite: $favorite';
  }

  Contact copyWith({
  int? id,
  String? name,
  String? mobile,
  String? landLine,
  bool? favorite,
  String? imageUrl,
  }) {
  return Contact(
  id: id ?? this.id,
  name: name ?? this.name,
  mobile: mobile ?? this.mobile,
  landLine: landLine ?? this.landLine,
  favorite: favorite ?? this.favorite,
  imageUrl: imageUrl ?? this.imageUrl,
  );
  }
}
