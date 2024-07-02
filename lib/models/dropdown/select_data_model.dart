class SelectDataModel {
  final String id;
  final String title;
  final String subTitle;
  final dynamic data;

  SelectDataModel({
    required this.id,
    required this.title,
    required this.subTitle,
    this.data,
  });

  @override
  String toString() {
    return 'SelectDataModel{id=$id, title=$title, subTitle=$subTitle, data=$data}';
  }
}
