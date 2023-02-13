class Notices {
  late int id;
  late String title;
  late String startDate;
  late String endDate;
  late String createdAt;
  late String updatedAt;
  final List<Files> files = [];

  Notices.fromJson(Map obj) {
    id = obj["id"] ?? 0;
    title = obj["title"] ?? "no title";
    startDate = obj["start_date"] ?? "no start date";
    endDate = obj["end_date"] ?? "no end date";
    createdAt = obj["createdAt"] ?? "no created at";
    updatedAt = obj["updatedAt"] ?? "no updated at";
    for (var f in obj["files"]) {
      files.add(Files.fromJson(f));
    }
  }
}

class Files {
  late String fileLink;
  late String fileType;

  Files.fromJson(Map obj) {
    fileLink = obj["file"];
    fileType = obj["file_type"];
  }

  @override
  String toString() {
    // TODO: implement toString
    return fileType;
  }
}
