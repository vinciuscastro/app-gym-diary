class Exercise {
  String id;
  String name;
  String description;
  String howTo;
  String? image;

  Exercise({
    required this.id,
    required this.name,
    required this.description,
    required this.howTo,
  });

  Exercise.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        description = json['description'],
        howTo = json['howTo'],
        image = json['image'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'howTo': howTo,
    'image': image,
  };

}