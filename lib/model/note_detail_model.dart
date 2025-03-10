class SingleNoteModel {
  String? id;
  String? salesman;
  String? title;
  String? note;

  SingleNoteModel({this.id, this.salesman, this.title, this.note});

  SingleNoteModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    salesman = json['salesman'];
    title = json['title'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['salesman'] = salesman;
    data['title'] = title;
    data['note'] = note;
    return data;
  }
}
