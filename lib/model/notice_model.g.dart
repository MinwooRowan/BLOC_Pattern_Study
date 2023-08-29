// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notice_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notice _$NoticeFromJson(Map<String, dynamic> json) => Notice(
      creator: json['creator'] as String,
      noticeID: json['noticeID'] as int,
      textBody: json['textBody'] as String,
    );

Map<String, dynamic> _$NoticeToJson(Notice instance) => <String, dynamic>{
      'noticeID': instance.noticeID,
      'textBody': instance.textBody,
      'creator': instance.creator,
    };
