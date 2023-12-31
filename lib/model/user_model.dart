class User {
  int? id;
  String? username;
  String? email;
  String? phone;
  String? role;
  String? address;
  String? imageName;
  String? emailVerifiedAt;
  String? authorization;

  User({
    this.id,
    this.username,
    this.email,
    this.phone,
    this.role,
    this.address,
    this.imageName,
    this.emailVerifiedAt,
    this.authorization,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    phone = json['phone'];
    role = json['role'];
    address = json['address'];
    imageName = json['image_name'];
    emailVerifiedAt = json['email_verified_at'];
    authorization = json['Authorization'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['email'] = email;
    data['phone'] = phone;
    data['role'] = role;
    data['address'] = address;
    data['image_name'] = imageName;
    data['email_verified_at'] = emailVerifiedAt;
    data['Authorization'] = authorization;
    return data;
  }

  @override
  String toString() {
    return 'User{id: $id, username: $username, email: $email, phone: $phone, '
        'role: $role, address: $address, imageName: $imageName, '
        'emailVerifiedAt: $emailVerifiedAt, authorization: $authorization}';
  }
}

final user = {
  "status": 200,
  "data": {
    "user": {
      "id": 15,
      "username": "ahmad nour haidar",
      "email": "ahmadnourhaidar@gmail.com",
      "phone": "0954609337",
      "role": "warehouseowner",
      "address": "address123",
      "image_name": null,
      "email_verified_at": "2023-12-19T00: 57: 17+03: 00",
      "Authorization":
          "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vcGhhcm1hZ2VkZG9uLW15cHJvamVjdC4wMDB3ZWJob3N0YXBwLmNvbS9hcGkvYXV0aC9jaGVja192ZXJpZmljYXRpb25fY29kZSIsImlhdCI6MTcwMjkzNjYzNywiZXhwIjoxNzM0NDk2NjM3LCJuYmYiOjE3MDI5MzY2MzcsImp0aSI6ImpielhjZFpHQlNnbVVNODAiLCJzdWIiOiIxNSIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjciLCJyb2xlIjoid2FyZWhvdXNlb3duZXIifQ.FRvkIsTrJnOkSpn-L1LkIq6OtsaZARmVhfCTaf71oh0"
    }
  },
  "message": {"custom_message": "Email has been verified."}
};

final user2 = {
  "status": 200,
  "data": {
    "user": {
      "id": 4,
      "username": "ahmad nour haidar",
      "email": "ahmadnourhaidar@gmail.com",
      "phone": "0999999999",
      "role": "warehouseowner",
      "address": "address123",
      "image_name": null,
      "email_verified_at": "2023-12-23T20:39:18+03:00",
      "Authorization":
          "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3BoYXJtYWdlZGRvbi1teXByb2plY3QuMDAwd2ViaG9zdGFwcC5jb20vYXBpL2F1dGgvY2hlY2tfdmVyaWZpY2F0aW9uX2NvZGUiLCJpYXQiOjE3MDMzNTMxNTgsImV4cCI6MTczNDkxMzE1OCwibmJmIjoxNzAzMzUzMTU4LCJqdGkiOiJGZm1jZERDTXoxUm5PbVpQIiwic3ViIjoiNCIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjciLCJyb2xlIjoid2FyZWhvdXNlb3duZXIifQ.3JncAqfUCQQaKiWoaw5cQ6ti4s5UGa_bF9DFjW6g5gY"
    }
  },
  "message": {"custom_message": "Email has been verified."}
};
