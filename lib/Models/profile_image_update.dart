class profileImageUpdate {
  String? message;
  String? url;

  profileImageUpdate({this.message, this.url});

  profileImageUpdate.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['url'] = this.url;
    return data;
  }
}