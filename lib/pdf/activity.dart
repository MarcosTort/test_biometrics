part 'activity.g.dart';

/// {@template activity}
/// Activity description
/// {@endtemplate}
class Activity {
  /// {@macro activity}
  const Activity({
    required this.transactionId,
    required this.date,
    required this.description,
    required this.ammount,
    required this.fee,
    required this.time,
    required this.referenceInformation,
  });

  /// Creates a Activity from Json map
  factory Activity.fromJson(Map<String, dynamic> data) =>
      _$ActivityFromJson(data);

  /// A description for transactionId
  final String transactionId;

  /// A description for date
  final DateTime date;

  /// A description for description
  final String description;

  /// A description for ammount
  final double ammount;

  /// A description for fee
  final double fee;

  /// A description for time
  final DateTime time;

  /// A description for referenceInformation
  final String referenceInformation;

  List<Object?> get props => [
        transactionId,
        date,
        description,
        ammount,
        fee,
        time,
        referenceInformation,
      ];

  /// Creates a Json map from a Activity
  Map<String, dynamic> toJson() => _$ActivityToJson(this);
}

final exampleActivities10 = [
  Activity(
    transactionId: '1',
    date: DateTime.now(),
    description: 'description',
    ammount: 1.0,
    fee: 1.0,
    time: DateTime.now(),
    referenceInformation: 'referenceInformation',
  ),
  Activity(
    transactionId: '2',
    date: DateTime.now(),
    description: 'description',
    ammount: 1.0,
    fee: 1.0,
    time: DateTime.now(),
    referenceInformation: 'referenceInformation',
  ),
  Activity(
    transactionId: '3',
    date: DateTime.now(),
    description: 'description',
    ammount: 1.0,
    fee: 1.0,
    time: DateTime.now(),
    referenceInformation: 'referenceInformation',
  ),
  Activity(
    transactionId: '4',
    date: DateTime.now(),
    description: 'description',
    ammount: 1.0,
    fee: 1.0,
    time: DateTime.now(),
    referenceInformation: 'referenceInformation',
  ),
  Activity(
    transactionId: '5',
    date: DateTime.now(),
    description: 'description',
    ammount: 1.0,
    fee: 1.0,
    time: DateTime.now(),
    referenceInformation: 'referenceInformation',
  ),
  Activity(
    transactionId: '6',
    date: DateTime.now(),
    description: 'description',
    ammount: 1.0,
    fee: 1.0,
    time: DateTime.now(),
    referenceInformation: 'referenceInformation',
  ),
  Activity(
    transactionId: '7',
    date: DateTime.now(),
    description: 'description',
    ammount: 1.0,
    fee: 1.0,
    time: DateTime.now(),
    referenceInformation: 'referenceInformation',
  ),
  Activity(
    transactionId: '8',
    date: DateTime.now(),
    description: 'description',
    ammount: 1,
    fee: 1.0,
    time: DateTime.now(),
    referenceInformation: 'referenceInformation',
  )
];
