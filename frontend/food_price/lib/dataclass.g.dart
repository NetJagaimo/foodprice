// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dataclass.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecipeSearch _$RecipeSearchFromJson(Map<String, dynamic> json) {
  return RecipeSearch(
    recipes: (json['recipes'] as List)
        ?.map((e) => e == null
            ? null
            : RecipeSummary.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$RecipeSearchToJson(RecipeSearch instance) =>
    <String, dynamic>{
      'recipes': instance.recipes,
    };

RecipeSummary _$RecipeSummaryFromJson(Map<String, dynamic> json) {
  return RecipeSummary(
    url: json['url'] as String,
    name: json['name'] as String,
    description: json['description'] as String,
    imageUrl: json['image_url'] as String,
    ingredientsPreview: json['ingredients_preview'] as String,
  );
}

Map<String, dynamic> _$RecipeSummaryToJson(RecipeSummary instance) =>
    <String, dynamic>{
      'url': instance.url,
      'name': instance.name,
      'description': instance.description,
      'image_url': instance.imageUrl,
      'ingredients_preview': instance.ingredientsPreview,
    };

Ingredient _$IngredientFromJson(Map<String, dynamic> json) {
  return Ingredient(
    name: json['name'] as String,
    unit: json['unit'] as String,
  );
}

Map<String, dynamic> _$IngredientToJson(Ingredient instance) =>
    <String, dynamic>{
      'name': instance.name,
      'unit': instance.unit,
    };

RecipeDetail _$RecipeDetailFromJson(Map<String, dynamic> json) {
  return RecipeDetail(
    groupName: json['group_name'] as String,
    ingredients: (json['ingredients'] as List)
        ?.map((e) =>
            e == null ? null : Ingredient.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$RecipeDetailToJson(RecipeDetail instance) =>
    <String, dynamic>{
      'group_name': instance.groupName,
      'ingredients': instance.ingredients,
    };

Recipe _$RecipeFromJson(Map<String, dynamic> json) {
  return Recipe(
    recipeDetail: (json['recipe_detail'] as List)
        ?.map((e) =>
            e == null ? null : RecipeDetail.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$RecipeToJson(Recipe instance) => <String, dynamic>{
      'recipe_detail': instance.recipeDetail,
    };

MomoIngredients _$MomoIngredientsFromJson(Map<String, dynamic> json) {
  return MomoIngredients(
    momoItems: (json['ingredients'] as List)
        ?.map((e) =>
            e == null ? null : MomoItems.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$MomoIngredientsToJson(MomoIngredients instance) =>
    <String, dynamic>{
      'ingredients': instance.momoItems,
    };

MomoItems _$MomoItemsFromJson(Map<String, dynamic> json) {
  return MomoItems(
    source: json['source'] as String,
    link: json['link'] as String,
    name: json['name'] as String,
    price: json['price'] as int,
    kg: (json['kg'] as num)?.toDouble(),
    pricePerKg: (json['price_per_kg'] as num)?.toDouble(),
    imageLink: json['image_link'] as String,
  );
}

Map<String, dynamic> _$MomoItemsToJson(MomoItems instance) => <String, dynamic>{
      'source': instance.source,
      'link': instance.link,
      'name': instance.name,
      'price': instance.price,
      'kg': instance.kg,
      'price_per_kg': instance.pricePerKg,
      'image_link': instance.imageLink,
    };
