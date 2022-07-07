import 'package:flutter/material.dart';
import 'package:recipe_list_app/models/recipe.dart';
import 'package:recipe_list_app/models/recipe_api.dart';
import 'package:recipe_list_app/views/widgets/recipe_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Recipe> _recipes;
  bool isLoading = true;

  @override
  void initState() {
    getRecipes();
    super.initState();
  }

  Future<void> getRecipes() async{
    _recipes = await RecipeApi.getRecipe();
    setState((){
      isLoading = false;
    });
    print(_recipes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.restaurant_menu),
            SizedBox(width: 10,),
            Text("Food Recipes"),
          ],
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
           itemCount: _recipes.length,
           itemBuilder: (context,index){
             return RecipeCard(
                 title: _recipes[index].name,
                 rating: _recipes[index].rating.toString(),
                 cookTime: _recipes[index].totalTime,
                 thumbnailUrl: _recipes[index].images,
             );
           },
      ),
    );
  }
}
