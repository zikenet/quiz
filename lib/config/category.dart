class Category {
  final int id;
  final String name;
  final String url;
  final int questions;

  Category({
    required this.id,
    required this.name,
    required this.url,
    required this.questions,
  });

  static List<Category> categories = [
    Category(
      id: 21,
      name: 'Sport',
      url: 'assets/icons/basketball.svg',
      questions: 20,
    ),
    Category(
      id: 17,
      name: 'Chemistry',
      url: 'assets/icons/chemistry.svg',
      questions: 30,
    ),
    Category(
      id: 19,
      name: 'Math',
      url: 'assets/icons/calculator.svg',
      questions: 10,
    ),
    Category(
      id: 23,
      name: 'History',
      url: 'assets/icons/calendar.svg',
      questions: 50,
    ),
    Category(
      id: 9,
      name: 'Biological',
      url: 'assets/icons/dna.svg',
      questions: 30,
    ),
    Category(
      id: 22,
      name: 'Geography',
      url: 'assets/icons/map.svg',
      questions: 24,
    ),
  ];
}
