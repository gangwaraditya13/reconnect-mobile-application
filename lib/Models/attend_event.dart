class AttendEvent {
  String? message;
  Event? event;

  AttendEvent({this.message, this.event});

  AttendEvent.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    event = json['event'] != null ? new Event.fromJson(json['event']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.event != null) {
      data['event'] = this.event!.toJson();
    }
    return data;
  }
}

class Event {
  String? sId;
  String? title;
  List<String>? attendees;

  Event({this.sId, this.title, this.attendees});

  Event.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    attendees = json['attendees'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['attendees'] = this.attendees;
    return data;
  }
}