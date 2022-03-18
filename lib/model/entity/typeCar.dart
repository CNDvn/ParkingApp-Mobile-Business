class TypeCar {
    TypeCar({
        required this.id,
        required this.name,
    });

    String id;
    String name;

    factory TypeCar.fromJson(Map<String, dynamic> json) => TypeCar(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}