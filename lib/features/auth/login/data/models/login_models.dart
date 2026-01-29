

import '../../domain/entities/login_entities.dart';

class LoginModel extends LoginEntities {
    final String? message;
    final int? status;
    final Data? data;
    final String? vccCode;
    final Errors? errors;

    LoginModel({
        this.message,
        this.status,
        this.data,
        this.vccCode,
        this.errors
    });

    factory LoginModel.fromJson(Map<String, dynamic> json) {
        return LoginModel(
            message: json["message"],
            status: json["status"],
            data: json["data"] == null ? null : Data.fromJson(json["data"]),
            vccCode: json["vcc_code"],
            errors: json["errors"] == null ||json["errors"] == ""? null : Errors.fromJson(json["errors"]),
        );
    }
}

class Data extends DataEntities {
    final String? token;
    final User? user;
    final String? message;

    Data({
        this.token,
        this.user,
        this.message
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        message: json["message"],
    );
}

class User extends UserEntities{
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
    final List<Role>? roles;
    final bool? isTester;

    User({
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
        this.roles,
        this.isTester,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        username: json["username"],
        emailVerifiedAt: json["email_verified_at"],
        apiToken: json["api_token"],
        lastLogin: json["last_login"] == null ? null : DateTime.parse(json["last_login"]),
        fullName: json["full_name"],
        password: json["password"],
        jabatan: json["jabatan"],
        department: json["department"],
        company: json["company"],
        nip: json["nip"],
        level: json["level"],
        unitCode: json["unit_code"],
        unitName: json["unit_name"],
        status: json["status"],
        rejectedAt: json["rejected_at"],
        rememberToken: json["remember_token"],
        phone: json["phone"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        roles: json["roles"] == null ? [] : List<Role>.from(json["roles"]!.map((x) => Role.fromJson(x))),
        isTester: json["is_tester"],
    );
}

class Role extends RoleEntities{
    final String? id;
    final String? name;
    final String? description;
    final int? level;
    final int? isEnabled;
    final int? isCommandCenter;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final dynamic deletedAt;
    final List<Permission>? permissions;

    Role({
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

    factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        level: json["level"],
        isEnabled: json["is_enabled"],
        isCommandCenter: json["is_command_center"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        permissions: json["permissions"] == null ? [] : List<Permission>.from(json["permissions"]!.map((x) => Permission.fromJson(x))),
    );
}

class Permission extends PermissionEntities{
    final String? id;
    final String? name;
    final String? slug;
    final String? parentId;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    Permission({
        this.id,
        this.name,
        this.slug,
        this.parentId,
        this.createdAt,
        this.updatedAt,
    });

    factory Permission.fromJson(Map<String, dynamic> json) => Permission(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        parentId: json["parent_id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );
}

class Errors extends ErrorsEnitites{
    final String? captcha;
    final String? email;

    Errors({
        this.captcha,
        this.email
    });

    factory Errors.fromJson(Map<String, dynamic> json) => Errors(
        captcha: json["captcha"],
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "captcha": captcha,
        "email": email,
    };
}
