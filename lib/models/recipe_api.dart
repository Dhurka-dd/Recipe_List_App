import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:recipe_list_app/models/recipe.dart';

class RecipeApi{

  static Future<List<Recipe>> getRecipe() async{
  var uri = Uri.https('yummly2.p.rapidapi.com','/feeds/list',
      {"limit": "24","start": "0","tag":"list.recipe.popular"});

  final response = await http.get(uri, headers: {
    "X-RapidAPI-Key": "282e00a671mshfc3e5b69f801c99p1a40f1jsn910a9bd90aa5",
    "X-RapidAPI-Host": "yummly2.p.rapidapi.com",
    "useQueryString": "true"
  });

  Map data = jsonDecode(response.body);
  List _temp = [];

  for(var i in data['feed']){
    _temp.add(i['content']['details']);
  }

  return Recipe.recipesFromSnapshot(_temp);
}




}