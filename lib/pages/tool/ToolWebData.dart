class ToolWebData {
    List<Data> data;
    int errorCode;
    String errorMsg;

    ToolWebData({this.data, this.errorCode, this.errorMsg});

    factory ToolWebData.fromJson(Map<String, dynamic> json) {
        return ToolWebData(
            data: json['data'] != null ? (json['data'] as List).map((i) => Data.fromJson(i)).toList() : null, 
            errorCode: json['errorCode'], 
            errorMsg: json['errorMsg'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['errorCode'] = this.errorCode;
        data['errorMsg'] = this.errorMsg;
        if (this.data != null) {
            data['data'] = this.data.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class Data {
    String icon;
    int id;
    String link;
    String name;
    int order;
    int visible;

    Data({this.icon, this.id, this.link, this.name, this.order, this.visible});

    factory Data.fromJson(Map<String, dynamic> json) {
        return Data(
            icon: json['icon'], 
            id: json['id'], 
            link: json['link'], 
            name: json['name'], 
            order: json['order'], 
            visible: json['visible'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['icon'] = this.icon;
        data['id'] = this.id;
        data['link'] = this.link;
        data['name'] = this.name;
        data['order'] = this.order;
        data['visible'] = this.visible;
        return data;
    }
}