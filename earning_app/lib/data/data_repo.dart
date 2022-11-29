import 'package:earning_app/data/data.dart';

class DataRepository {
  static Future<List<EachResult>?> getValues() async {
    List<EachResult>? results;

    final listValues = JsonResults.fromJson(Data.data);
    return results = listValues.result;
  }
}

class JsonResults {
  JsonResults({required this.result});

  List<EachResult> result;

  factory JsonResults.fromJson(Map<String, dynamic> json) => JsonResults(
        result: List<EachResult>.from(
            (json["result"] as Iterable).map((x) => EachResult.fromJson(x))),
      );
}

class EachResult {
  EachResult({
    required this.id,
    required this.name,
    required this.imagepath,
    required this.type,
  });

  int id;
  String name;
  String imagepath;
  String type;

  factory EachResult.fromJson(Map<String, dynamic> json) => EachResult(
        id: json["id"],
        name: json["name"],
        imagepath: json["imagepath"],
        type: json["Type"],
      );
}
