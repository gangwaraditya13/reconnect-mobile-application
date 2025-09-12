class EventsFetch {
  String? message;
  List<Events>? events;

  EventsFetch({this.message, this.events});

  EventsFetch.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['events'] != null) {
      events = <Events>[];
      json['events'].forEach((v) {
        events!.add(new Events.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.events != null) {
      data['events'] = this.events!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Events {
  String? sId;
  String? title;
  String? description;
  String? date;
  String? location;
  String? createdBy;
  String? status;

  Events(
      {this.sId,
        this.title,
        this.description,
        this.date,
        this.location,
        this.createdBy,
        this.status});

  Events.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    date = json['date'];
    location = json['location'];
    createdBy = json['createdBy'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['date'] = this.date;
    data['location'] = this.location;
    data['createdBy'] = this.createdBy;
    data['status'] = this.status;
    return data;
  }
}