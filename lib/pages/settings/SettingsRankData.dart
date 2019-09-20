class SettingsRankData {
    Data data;
    int errorCode;
    String errorMsg;

    SettingsRankData({this.data, this.errorCode, this.errorMsg});

    factory SettingsRankData.fromJson(Map<String, dynamic> json) {
        return SettingsRankData(
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
    int coinCount;
    int rank;
    int userId;
    String username;

    Data({this.coinCount, this.rank, this.userId, this.username});

    factory Data.fromJson(Map<String, dynamic> json) {
        return Data(
            coinCount: json['coinCount'], 
            rank: json['rank'], 
            userId: json['userId'], 
            username: json['username'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['coinCount'] = this.coinCount;
        data['rank'] = this.rank;
        data['userId'] = this.userId;
        data['username'] = this.username;
        return data;
    }
}