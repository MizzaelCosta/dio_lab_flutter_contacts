// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Contact {
  Contact({
    required this.id,
    required this.name,
    required this.phone,
    this.mail,
    this.image,
  });

  final String id;
  final String name;
  final String phone;
  final String? mail;
  final String? image;

  Contact copyWith({
    String? id,
    String? name,
    String? phone,
    String? mail,
    String? image,
  }) {
    return Contact(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      mail: mail ?? this.mail,
      image: image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'phone': phone,
      'mail': mail,
      'image': image,
    };
  }

  factory Contact.fromMap(Map map) {
    return Contact(
      id: map['id'] as String,
      name: map['name'] as String,
      phone: map['phone'] as String,
      mail: map['mail'] != null ? map['mail'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Contact.fromJson(String contact) =>
      Contact.fromMap(json.decode(contact) as Map);

  @override
  String toString() {
    return 'Contact(id: $id, name: $name, phone: $phone, mail: $mail, image: $image)';
  }

  @override
  bool operator ==(covariant Contact other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.phone == phone &&
        other.mail == mail &&
        other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        phone.hashCode ^
        mail.hashCode ^
        image.hashCode;
  }
}
