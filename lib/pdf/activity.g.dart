part of 'activity.dart';

Activity _$ActivityFromJson(Map<String, dynamic> json) => Activity(
      transactionId: json['transactionId'] as String,
      date: DateTime.now(),//DateTime.fromJson(json['date'] as Map<String, dynamic>),
      description: json['description'] as String,
      ammount: json['ammount'] as double,
      fee: json['fee'] as double,
      time:  DateTime.now(),//DateTime.fromJson(json['time'] as Map<String, dynamic>),
      referenceInformation: json['referenceInformation'] as String,
    );

Map<String, dynamic> _$ActivityToJson(Activity instance) => <String, dynamic>{ 
      'transactionId': instance.transactionId,
      'date': instance.date,
      'description': instance.description,
      'ammount': instance.ammount,
      'fee': instance.fee,
      'time': instance.time,
      'referenceInformation': instance.referenceInformation,
    };