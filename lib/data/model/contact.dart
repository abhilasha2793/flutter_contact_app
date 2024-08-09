// A class for representing a contact data model
class Contact {
  int? id;
  String name;
  String mobile;
  String? landLine;
  String? imageUrl;
  bool favorite;

  Contact({
    this.id,
    required this.name,
    required this.mobile,
    this.landLine,
    this.imageUrl,
    this.favorite = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'mobile': mobile,
      'landLine': landLine,
      'imageUrl': imageUrl,
      'favorite': favorite ? 1 : 0,
    };
  }

  Contact copyWith({
    int? id,
    String? name,
    String? mobile,
    String? landLine,
    String? imageUrl,
    bool? favorite,
  }) {
    return Contact(
      id: id ?? this.id,
      name: name ?? this.name,
      mobile: mobile ?? this.mobile,
      landLine: landLine ?? this.landLine,
      imageUrl: imageUrl ?? this.imageUrl,
      favorite: favorite ?? this.favorite,
    );
  }
}