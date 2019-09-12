class RegisterResultData {
    Data data;
    int errorCode;
    String errorMsg;

    RegisterResultData({this.data, this.errorCode, this.errorMsg});

    factory RegisterResultData.fromJson(Map<String, dynamic> json) {
        return RegisterResultData(
            data: json['data'] != null ? Data.fromJson(json['data']) : null, 
            errorCode: json['errorCode'], 
            errorMsg: json['errorMsg'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['errorCode'] = this.errorCode;
        data['errorMsg'] = this.errorMsg;
        if (this.data != null) {
            data['data'] = this.data.toJson();
        }
        return data;
    }
}

class Data {
    bool admin;
    List<Object> chapterTops;
    List<Object> collectIds;
    String email;
    String icon;
    int id;
    String nickname;
    String password;
    String token;
    int type;
    String username;

    Data({this.admin, this.chapterTops, this.collectIds, this.email, this.icon, this.id, this.nickname, this.password, this.token, this.type, this.username});

    factory Data.fromJson(Map<String, dynamic> json) {
        return Data(
            admin: json['admin'], 
            email: json['email'],
            icon: json['icon'], 
            id: json['id'], 
            nickname: json['nickname'], 
            password: json['password'], 
            token: json['token'], 
            type: json['type'], 
            username: json['username'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['admin'] = this.admin;
        data['email'] = this.email;
        data['icon'] = this.icon;
        data['id'] = this.id;
        data['nickname'] = this.nickname;
        data['password'] = this.password;
        data['token'] = this.token;
        data['type'] = this.type;
        data['username'] = this.username;
        return data;
    }
}