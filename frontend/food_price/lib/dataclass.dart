import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/material.dart';

part 'dataclass.g.dart';

@JsonSerializable()
class Ingredient {
  String name;
  String unit;

  Ingredient({this.name, this.unit});

  factory Ingredient.fromJson(Map<String, dynamic> json) => _$IngredientFromJson(json);

  Map<String, dynamic> toJson() => _$IngredientToJson(this);
}

@JsonSerializable()
class RecipeDetail {
  @JsonKey(name: 'group_name')
  String groupName;
  List<Ingredient> ingredients;

  RecipeDetail({this.groupName, this.ingredients});

  factory RecipeDetail.fromJson(Map<String, dynamic> json) => _$RecipeDetailFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeDetailToJson(this);
}

@JsonSerializable()
class Recipe {
  @JsonKey(name: 'resipe_detail')
  List<RecipeDetail> recipeDetail;

  Recipe({this.recipeDetail});
  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeToJson(this);
}

Future<Recipe> parseRecipeJson() async {
  var jsonText = await rootBundle.loadString('result.json');
  // print(json.decode(jsonText));
  var recipes = Recipe.fromJson(json.decode(jsonText));
  print(recipes.recipeDetail.last.ingredients.first.name);
  return recipes;
}

// 食材搜尋解析
@JsonSerializable()
class MomoIngredients {
  @JsonKey(name: 'ingredients')
  List<MomoItems> momoItems;

  MomoIngredients({this.momoItems});

  factory MomoIngredients.fromJson(Map<String, dynamic> json) => _$MomoIngredientsFromJson(json);

  Map<String, dynamic> toJson() => _$MomoIngredientsToJson(this);
}

@JsonSerializable()
class MomoItems {
  String source;
  String link;
  String name;
  int price;
  double kg;
  @JsonKey(name: 'price_per_kg')
  double pricePerKg;
  @JsonKey(name: 'image_link')
  String imageLink;

  MomoItems(
      {this.source,
        this.link,
        this.name,
        this.price,
        this.kg,
        this.pricePerKg,
        this.imageLink});

  factory MomoItems.fromJson(Map<String, dynamic> json) => _$MomoItemsFromJson(json);

  Map<String, dynamic> toJson() => _$MomoItemsToJson(this);
}

Future<MomoIngredients> getIngredientsFromMomo(String ingredient) async {
  final api = env['INGREDIENT_API'];
  final response = await http.get(
      Uri.parse(api+ingredient),
  );
  if (response.statusCode == 200) {
    return MomoIngredients.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  } else {
    throw HttpException(
        'Unexpected status code ${response.statusCode}:'
            ' ${response.reasonPhrase}',
        uri: Uri.parse(api+ingredient));
  }
}

Image corsImage(String url){
  return Image.network(
    env['CORS_PROXY']+url,
    width: 30,
    headers: {'X-Requested-With':'XMLHttpRequest'},);
}
void main(){
  parseRecipeJson();
}