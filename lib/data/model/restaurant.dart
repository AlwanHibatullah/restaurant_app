import 'dart:convert';

class Restaurant {
  List<Restaurants> restaurants;

  Restaurant({this.restaurants});

  Restaurant.fromJson(Map<String, dynamic> json) {
    if (json["restaurants"] != null) {
      restaurants = [];
      json["restaurants"].forEach((v) {
        restaurants.add(Restaurants.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (restaurants != null) {
      map["restaurants"] = restaurants.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Restaurants {
  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;
  Menus menus;

  Restaurants(
      {this.id,
      this.name,
      this.description,
      this.pictureId,
      this.city,
      this.rating,
      this.menus});

  Restaurants.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    description = json["description"];
    pictureId = json["pictureId"];
    city = json["city"];
    rating = json["rating"];
    menus = json["menus"] != null ? Menus.fromJson(json["menus"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["name"] = name;
    map["description"] = description;
    map["pictureId"] = pictureId;
    map["city"] = city;
    map["rating"] = rating;
    if (menus != null) {
      map["menus"] = menus.toJson();
    }
    return map;
  }
}

class Menus {
  List<Foods> foods;
  List<Drinks> drinks;

  Menus({this.foods, this.drinks});

  Menus.fromJson(Map<String, dynamic> json) {
    if (json["foods"] != null) {
      foods = [];
      json["foods"].forEach((v) {
        foods.add(Foods.fromJson(v));
      });
    }
    if (json["drinks"] != null) {
      drinks = [];
      json["drinks"].forEach((v) {
        drinks.add(Drinks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (foods != null) {
      map["foods"] = foods.map((v) => v.toJson()).toList();
    }
    if (drinks != null) {
      map["drinks"] = drinks.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Drinks {
  String name;

  Drinks({this.name});

  Drinks.fromJson(Map<String, dynamic> json) {
    name = json["name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = name;
    return map;
  }
}

class Foods {
  String name;

  Foods({this.name});

  Foods.fromJson(Map<String, dynamic> json) {
    name = json["name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = name;
    return map;
  }
}

List<Restaurant> parsedRestaurant(String json) {
  if (json == null) return [];
  final List parsed = jsonDecode(json)['restaurants'];
  return parsed.map((json) => Restaurant.fromJson(json)).toList();
}
