class SystemMainData {
    List<Data> data;

    SystemMainData({this.data});

    factory SystemMainData.fromJson(Map<String, dynamic> json) {
        return SystemMainData(
            data: json['data'] != null ? (json['data'] as List).map((i) => Data.fromJson(i)).toList() : null, 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        if (this.data != null) {
            data['data'] = this.data.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class Data {
    List<Children> children;
    int courseId;
    int id;
    String name;
    int order;
    int parentChapterId;
    bool userControlSetTop;
    int visible;

    Data({this.children, this.courseId, this.id, this.name, this.order, this.parentChapterId, this.userControlSetTop, this.visible});

    factory Data.fromJson(Map<String, dynamic> json) {
        return Data(
            children: json['children'] != null ? (json['children'] as List).map((i) => Children.fromJson(i)).toList() : null, 
            courseId: json['courseId'], 
            id: json['id'], 
            name: json['name'], 
            order: json['order'], 
            parentChapterId: json['parentChapterId'], 
            userControlSetTop: json['userControlSetTop'], 
            visible: json['visible'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['courseId'] = this.courseId;
        data['id'] = this.id;
        data['name'] = this.name;
        data['order'] = this.order;
        data['parentChapterId'] = this.parentChapterId;
        data['userControlSetTop'] = this.userControlSetTop;
        data['visible'] = this.visible;
        if (this.children != null) {
            data['children'] = this.children.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class Children {
    List<Object> children;
    int courseId;
    int id;
    String name;
    int order;
    int parentChapterId;
    bool userControlSetTop;
    int visible;

    Children({this.children, this.courseId, this.id, this.name, this.order, this.parentChapterId, this.userControlSetTop, this.visible});

    factory Children.fromJson(Map<String, dynamic> json) {
        return Children(
            courseId: json['courseId'],
            id: json['id'], 
            name: json['name'], 
            order: json['order'], 
            parentChapterId: json['parentChapterId'], 
            userControlSetTop: json['userControlSetTop'], 
            visible: json['visible'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['courseId'] = this.courseId;
        data['id'] = this.id;
        data['name'] = this.name;
        data['order'] = this.order;
        data['parentChapterId'] = this.parentChapterId;
        data['userControlSetTop'] = this.userControlSetTop;
        data['visible'] = this.visible;
        return data;
    }
}