class WeChatDetailData {
    Data data;

    WeChatDetailData({this.data});

    factory WeChatDetailData.fromJson(Map<String, dynamic> json) {
        return WeChatDetailData(
            data: json['data'] != null ? Data.fromJson(json['data']) : null, 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        if (this.data != null) {
            data['data'] = this.data.toJson();
        }
        return data;
    }
}

class Data {
    int curPage;
    List<DataX> datas;

    Data({this.curPage, this.datas});

    factory Data.fromJson(Map<String, dynamic> json) {
        return Data(
            curPage: json['curPage'], 
            datas: json['datas'] != null ? (json['datas'] as List).map((i) => DataX.fromJson(i)).toList() : null, 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['curPage'] = this.curPage;
        if (this.datas != null) {
            data['datas'] = this.datas.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class DataX {
    String apkLink;
    int audit;
    String author;
    int chapterId;
    String chapterName;
    bool collect;
    int courseId;
    String desc;
    String envelopePic;
    bool fresh;
    int id;
    String link;
    String niceDate;
    String niceShareDate;
    String origin;
    String prefix;
    String projectLink;
    int publishTime;
    Object shareDate;
    String shareUser;
    int superChapterId;
    String superChapterName;
    List<Tag> tags;
    String title;
    int type;
    int userId;
    int visible;
    int zan;

    DataX({this.apkLink, this.audit, this.author, this.chapterId, this.chapterName, this.collect, this.courseId, this.desc, this.envelopePic, this.fresh, this.id, this.link, this.niceDate, this.niceShareDate, this.origin, this.prefix, this.projectLink, this.publishTime, this.shareDate, this.shareUser, this.superChapterId, this.superChapterName, this.tags, this.title, this.type, this.userId, this.visible, this.zan});

    factory DataX.fromJson(Map<String, dynamic> json) {
        return DataX(
            apkLink: json['apkLink'], 
            audit: json['audit'], 
            author: json['author'], 
            chapterId: json['chapterId'], 
            chapterName: json['chapterName'], 
            collect: json['collect'], 
            courseId: json['courseId'], 
            desc: json['desc'], 
            envelopePic: json['envelopePic'], 
            fresh: json['fresh'], 
            id: json['id'], 
            link: json['link'], 
            niceDate: json['niceDate'], 
            niceShareDate: json['niceShareDate'], 
            origin: json['origin'], 
            prefix: json['prefix'], 
            projectLink: json['projectLink'], 
            publishTime: json['publishTime'], 
            shareUser: json['shareUser'],
            superChapterId: json['superChapterId'], 
            superChapterName: json['superChapterName'], 
            tags: json['tags'] != null ? (json['tags'] as List).map((i) => Tag.fromJson(i)).toList() : null, 
            title: json['title'], 
            type: json['type'], 
            userId: json['userId'], 
            visible: json['visible'], 
            zan: json['zan'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['apkLink'] = this.apkLink;
        data['audit'] = this.audit;
        data['author'] = this.author;
        data['chapterId'] = this.chapterId;
        data['chapterName'] = this.chapterName;
        data['collect'] = this.collect;
        data['courseId'] = this.courseId;
        data['desc'] = this.desc;
        data['envelopePic'] = this.envelopePic;
        data['fresh'] = this.fresh;
        data['id'] = this.id;
        data['link'] = this.link;
        data['niceDate'] = this.niceDate;
        data['niceShareDate'] = this.niceShareDate;
        data['origin'] = this.origin;
        data['prefix'] = this.prefix;
        data['projectLink'] = this.projectLink;
        data['publishTime'] = this.publishTime;
        data['shareUser'] = this.shareUser;
        data['superChapterId'] = this.superChapterId;
        data['superChapterName'] = this.superChapterName;
        data['title'] = this.title;
        data['type'] = this.type;
        data['userId'] = this.userId;
        data['visible'] = this.visible;
        data['zan'] = this.zan;
        if (this.tags != null) {
            data['tags'] = this.tags.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class Tag {
    String name;
    String url;

    Tag({this.name, this.url});

    factory Tag.fromJson(Map<String, dynamic> json) {
        return Tag(
            name: json['name'], 
            url: json['url'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['name'] = this.name;
        data['url'] = this.url;
        return data;
    }
}