import 'package:equatable/equatable.dart';
// For JSON encoding and decoding

class LoginEntities extends Equatable {
  final int? status;
  final String? message;
  final DataEntities? data;
  final String? vccCode;
  final ErrorsEnitites? errors;

  const LoginEntities({this.status, this.message, this.data, this.vccCode, this.errors});

  @override
  List<Object?> get props => [status, message, data, errors,vccCode];

  // JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'vcc_code': vccCode,
      'data': data?.toJson(),
      'errors': errors?.toJson(),
    };
  }

  factory LoginEntities.fromJson(Map<String, dynamic> json) {
    return LoginEntities(
      status: json['status'],
      message: json['message'],
      vccCode: json['vcc_code'],
      data: json['data'] != null ? DataEntities.fromJson(json['data']) : null,
      errors: json['errors'] != null ? ErrorsEnitites.fromJson(json['errors']) : null,
    );
  }
}

class DataEntities extends Equatable {
  final String? token;
  final UserEntities? user;
  final String? message;

  const DataEntities({this.token, this.user, this.message});

  @override
  List<Object?> get props => [token, user, message];

  // JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'user': user?.toJson(),
    };
  }

  factory DataEntities.fromJson(Map<String, dynamic> json) {
    return DataEntities(
      token: json['token'],
      user: json['user'] != null ? UserEntities.fromJson(json['user']) : null,
    );
  }
}

class UserEntities extends Equatable {
  final String? id;
  final String? email;
  final String? username;
  final dynamic emailVerifiedAt;
  final dynamic apiToken;
  final DateTime? lastLogin;
  final String? fullName;
  final String? password;
  final String? jabatan;
  final String? department;
  final String? company;
  final String? nip;
  final String? level;
  final String? unitCode;
  final String? unitName;
  final int? status;
  final dynamic rejectedAt;
  final dynamic rememberToken;
  final dynamic phone;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final List<RoleEntities>? roles;
  final bool? isTester;

  UserEntities({
    this.id,
    this.email,
    this.username,
    this.emailVerifiedAt,
    this.apiToken,
    this.lastLogin,
    this.fullName,
    this.password,
    this.jabatan,
    this.department,
    this.company,
    this.nip,
    this.level,
    this.unitCode,
    this.unitName,
    this.status,
    this.rejectedAt,
    this.rememberToken,
    this.phone,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.isTester,
    this.roles,
  });

  @override
  List<Object?> get props => [
    id,
    email,
    username,
    emailVerifiedAt,
    apiToken,
    lastLogin,
    fullName,
    password,
    jabatan,
    department,
    company,
    nip,
    level,
    unitCode,
    unitName,
    status,
    rejectedAt,
    rememberToken,
    phone,
    createdAt,
    updatedAt,
    deletedAt,
    roles,
    isTester,
  ];

  // JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'emailVerifiedAt': emailVerifiedAt,
      'apiToken': apiToken,
      'lastLogin': lastLogin?.toIso8601String(),
      'fullName': fullName,
      'password': password,
      'jabatan': jabatan,
      'department': department,
      'company': company,
      'nip': nip,
      'level': level,
      'unitCode': unitCode,
      'unitName': unitName,
      'status': status,
      'rejectedAt': rejectedAt,
      'rememberToken': rememberToken,
      'phone': phone,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'deletedAt': deletedAt,
      'isTester': isTester,
      'roles': roles?.map((role) => role.toJson()).toList(),
    };
  }

  factory UserEntities.fromJson(Map<String, dynamic> json) {
    return UserEntities(
      id: json['id'],
      email: json['email'],
      username: json['username'],
      emailVerifiedAt: json['emailVerifiedAt'],
      apiToken: json['apiToken'],
      lastLogin: json['lastLogin'] != null ? DateTime.parse(json['lastLogin']) : null,
      fullName: json['fullName'],
      password: json['password'],
      jabatan: json['jabatan'],
      department: json['department'],
      company: json['company'],
      nip: json['nip'],
      level: json['level'],
      unitCode: json['unitCode'],
      unitName: json['unitName'],
      status: json['status'],
      rejectedAt: json['rejectedAt'],
      rememberToken: json['rememberToken'],
      phone: json['phone'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      deletedAt: json['deletedAt'],
      isTester: json['isTester'],
      roles: (json['roles'] as List?)?.map((role) => RoleEntities.fromJson(role)).toList(),
    );
  }
}

class RoleEntities extends Equatable {
  final String? id;
  final String? name;
  final String? description;
  final int? level;
  final int? isEnabled;
  final int? isCommandCenter;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final List<PermissionEntities>? permissions;

  RoleEntities({
    this.id,
    this.name,
    this.description,
    this.level,
    this.isEnabled,
    this.isCommandCenter,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.permissions,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    level,
    isEnabled,
    isCommandCenter,
    createdAt,
    updatedAt,
    deletedAt,
    permissions,
  ];

  // JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'level': level,
      'isEnabled': isEnabled,
      'isCommandCenter': isCommandCenter,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'deletedAt': deletedAt,
      'permissions': permissions?.map((permission) => permission.toJson()).toList(),
    };
  }

  factory RoleEntities.fromJson(Map<String, dynamic> json) {
    return RoleEntities(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      level: json['level'],
      isEnabled: json['isEnabled'],
      isCommandCenter: json['isCommandCenter'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      deletedAt: json['deletedAt'],
      permissions: (json['permissions'] as List?)?.map((perm) => PermissionEntities.fromJson(perm)).toList(),
    );
  }
}

class PermissionEntities extends Equatable {
  final String? id;
  final String? name;
  final String? slug;
  final String? parentId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  PermissionEntities({
    this.id,
    this.name,
    this.slug,
    this.parentId,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [id, name, slug, parentId, createdAt, updatedAt];

  // JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'parentId': parentId,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory PermissionEntities.fromJson(Map<String, dynamic> json) {
    return PermissionEntities(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      parentId: json['parentId'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }
}

class ErrorsEnitites extends Equatable {
  final String? captcha;
  final String? email;

  const ErrorsEnitites({this.captcha,this.email});

  @override
  List<Object?> get props => [captcha, email];

  // JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'captcha': captcha,
      'email': email,
    };
  }

  factory ErrorsEnitites.fromJson(Map<String, dynamic> json) {
    return ErrorsEnitites(
      captcha: json['captcha'],
      email: json['email'],
    );
  }
}
