import 'package:json_annotation/json_annotation.dart';

part 'notice_model.g.dart';

@JsonSerializable()
class Notice {
  final int noticeID;
  final String textBody;
  final String creator;
  Notice({
    required this.creator,
    required this.noticeID,
    required this.textBody,
  });

  factory Notice.fromJson(Map<String, dynamic> json) => _$NoticeFromJson(json);
}
