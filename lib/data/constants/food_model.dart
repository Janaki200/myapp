class FoodModel {
  static const List suggestions = [
    {"id": 0, "name": "All", "image": ""},
    {"id": 1, "name": "Salads", "image": "assets/items/veg salad.jpg"},
    {"id": 2, "name": "Shakes", "image": "assets/items/strawberry shake.jpg"},
    {
      "id": 3,
      "name": "Lunch Bowl",
      "image": "assets/items/deit lunch pack.jpg"
    },
    {
      "id": 4,
      "name": "Dinner Bowl",
      "image": "assets/items/mixed veggies chicken bowl.jpg"
    },
  ];

  static const List foodItems = [
    {
      "id": 1,
      "name": "veggie bowl",
      "description": "veggies bowl with avocado and pulses ",
      "recipe":
          "avocado,cherry tomatoes ,spinach,corn,pulses with lemon dressing",
      "price": 140.00,
      "category": "Salads",
      "image": "assets/items/veggie bowl.jpg",
      //When the cusomization is not available
      "isCustomizable": false,
      "customValues": []
    },
    {
      "id": 2,
      "name": "balanced bowl",
      "description":
          "weight loss meal with mixed veggies and grilled chicken breast ",
      "recipe": " grilled chicken breast ,broccoli,sprouted cereals,cabbages",
      "price": 210.00,
      "category": "Lunch Bowl",
      "image": "assets/items/Balanced bowl.jpg",
      "isCustomizable": true,
      "customValues": [
        {"name": "Chicken", "price": 50.00},
        {"name": "Broccoli", "price": 25.00},
        {"name": "Cabbages", "price": 15.00}
      ]
    },
    {
      "id": 3,
      "name": "Blueberry Shake",
      "description": "sugarfree Blueberry shake  ",
      "recipe": "Blueberry,honey,milk",
      "price": 180.00,
      "category": "Shakes",
      "image": "assets/items/blueberry shake.jpg",
      "isCustomizable": true,
      "customValues": [
        {"name": "Blueberry", "price": 50.00},
        {"name": "Honey", "price": 25.00}
      ]
    },
    {
      "id": 4,
      "name": "broccoli salad",
      "description": "vegetables with toasted broccoli and lemon dressing. ",
      "recipe": "toated broccoli ,carrots,tomatoes,onion,lemon dressing",
      "price": 140.00,
      "category": "Salads",
      "image": "assets/items/broccoli salad.jpg",
      "isCustomizable": true,
      "customValues": [
        {"name": "Broccoli", "price": 50.00},
        {"name": "Carrots", "price": 25.00},
        {"name": "Tomatoes", "price": 15.00}
      ]
    },
    {
      "id": 5,
      "name": "Chicken Breast Platter",
      "description": "chicken breast with toated broccoli",
      "recipe": "airfried chicken breast ,toated broccoli ,rice",
      "price": 240.00,
      "category": "Lunch Bowl",
      "image": "assets/items/chicken breast platter.jpg",
      //When the cusomization is  available
      "isCustomizable": true,
      "customValues": [
        {"name": "Chicken", "price": 50.00},
        {"name": "Brocoli", "price": 25.00}
      ]
    },
    {
      "id": 6,
      "name": "Veg Salad",
      "description": "vegetable salad with lettuce and tomato",
      "recipe": "lettuce,cucumber,cherry tomatoes with mayo dressing",
      "price": 140.00,
      "category": "Salads",
      "image": "assets/items/veg salad.jpg",
      "isCustomizable": true,
      "customValues": [
        {"name": "Lettuce", "price": 40.00},
        {"name": "Cucumber", "price": 20.00},
        {"name": "Tomatoes", "price": 15.00}
      ]
    },
    {
      "id": 8,
      "name": "Veg salad with Shredded cheese",
      "description": "Semi sorted vegetable salad with shredded cheese",
      "recipe": "cucumber,tomatoes,lettuce,pineapple,mayo,shredded cheese",
      "price": 160.00,
      "category": "Salads",
      "image": "assets/items/veg salad with shredded cheese.jpg",
      "isCustomizable": true,
      "customValues": [
        {"name": "Lettuce", "price": 40.00},
        {"name": "cheese", "price": 30.00},
      ]
    },
    {
      "id": 9,
      "name": "Deit Lunch Pack",
      "description":
          " A perfect lunch packgrilled chicken with rice and veggies",
      "recipe": "masala grilled chicken,salad,boiled egg",
      "price": 230.00,
      "category": "Lunch Bowl",
      "image": "assets/items/deit lunch pack.jpg",
      "isCustomizable": true,
      "customValues": [
        {"name": "Chicken", "price": 50.00},
        {"name": "Salad", "price": 60.00},
        {"name": "Egg", "price": 15.00}
      ]
    },
    {
      "id": 10,
      "name": "Deit Shake",
      "description": "Weight gain Protein shake with mint  ",
      "recipe": "Oat milk,peanut,mint",
      "price": 180.00,
      "category": "Shakes",
      "image": "assets/items/deit shake.jpg",
      "isCustomizable": true,
      "customValues": [
        {"name": "mint", "price": 10.00},
        {"name": "Peanut", "price": 20.00},
      ]
    },
    {
      "id": 11,
      "name": "Avocado shake",
      "description": "Avocado shake with mint ",
      "recipe": "Avocado,mint,Grape fruit",
      "price": 160.00,
      "category": "Shakes",
      "image": "assets/items/grapefruit avocado shake.jpg",
      "isCustomizable": true,
      "customValues": [
        {"name": "Avocado", "price": 20.00},
        {"name": "Grapefruit", "price": 20.00},
        {"name": "mint", "price": 10.00}
      ]
    },
    {
      "id": 12,
      "name": "Mixed veggies chicken bowl",
      "description":
          "Different types of vegetbles with piece of chicken Breast",
      "recipe": "zuchini,boiled chicken breast,rice,cookrd cereals",
      "price": 250.00,
      "category": "Dinner Bowl",
      "image": "assets/items/mixed veggies chicken bowl.jpg",
      "isCustomizable": true,
      "customValues": [
        {"name": "Zuchini", "price": 20.00},
        {"name": "Chicken", "price": 50.00},
        {"name": "Rice", "price": 35.00},
      ]
    },
    {
      "id": 13,
      "name": "Strawberry Shake",
      "description": "Sugarfree Strawberry shake",
      "recipe": "strawberry,honey,milk",
      "price": 90.00,
      "category": "Shakes",
      "image": "assets/items/strawberry shake.jpg",
      "isCustomizable": true,
      "customValues": [
        {"name": "Strawberry", "price": 40.00},
        {"name": "Honey", "price": 20.00}
      ]
    },
    {
      "id": 14,
      "name": "Strawberry chia Shake",
      "description": "Sugarfree high in vitamin chia Strawberry shake",
      "recipe": "strawberry,honey,milk,soaked chia seed",
      "price": 110.00,
      "category": "Shakes",
      "image": "assets/items/strawberry chia shake.jpg",
      "isCustomizable": true,
      "customValues": [
        {"name": "Strawberry", "price": 40.00},
        {"name": "Honey", "price": 20.00},
        {"name": "Chia seed", "price": 10.00}
      ]
    },
    {
      "id": 15,
      "name": "Deit dinner pack",
      "description": "griiled chicken with chana pulse and salad",
      "recipe":
          "boneless Chicken,chana pulses,brocclli,cherry tomatoes,cucumber",
      "category": "Dinner Bowl",
      "price": 90.00,
      "image": "assets/items/deit dinner pack with chicken.jpg",
      "isCustomizable": true,
      "customValues": [
        {"name": "Chicken", "price": 50.00},
        {"name": "Brocoli", "price": 25.00},
        {"name": "Salad", "price": 60.00}
      ]
    },
    {
      "id": 16,
      "name": "Grilled Chicken Breast",
      "description": "Masala grilled Chicken ",
      "recipe": "2 grilled Chicken Breast with Spinach ",
      "price": 190.00,
      "category": "Dinner Bowl",
      "image": "assets/items/grilled chicken breast.jpg",
      "isCustomizable": true,
      "customValues": [
        {"name": "Chicken", "price": 50.00},
        {"name": "Spinach", "price": 25.00}
      ]
    },
    {
      "id": 17,
      "name": "Heavy Lunch Meal ",
      "description": "Grilled chicken with pulses and asperatus",
      "recipe": "2-3 grilled chicken Breast,asperatus,chana pulses",
      "price": 260.00,
      "category": "Lunch Bowl",
      "image": "assets/items/heavy lunch meal.jpg",
      "isCustomizable": true,
      "customValues": [
        {"name": "Chicken", "price": 50.00},
        {"name": "Asparagus", "price": 25.00},
      ]
    },
  ];
}
