class Activity {
  final String id;
  final String title;
  final DateTime time;
  final int duration;
  final String location;
  final int spotsLeft;
  final double price;
  final String category;
  final String intensity;
  final bool hasChildcare;

  Activity({
    required this.id,
    required this.title,
    required this.time,
    required this.duration,
    required this.location,
    required this.spotsLeft,
    required this.price,
    required this.category,
    required this.intensity,
    required this.hasChildcare,
  });
}