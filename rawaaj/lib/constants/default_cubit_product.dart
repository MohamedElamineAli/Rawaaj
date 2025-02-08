import 'dart:io';

import '../models/outfit_model.dart';
import '../models/product_model.dart';

final defaultCubitProduct = Product(
  id: 1,
  images: [],
  categoryId: 3,
  price: 0.0,
  isLiked: false,
  description: '',
  variation: [],
  totalRatings: 0.0,
  reviews: [],
  materials: [],
  origin: '',
  sizes: [],
  colors: [],
  shopId: 1,
);

final defaultCubitOutfit = Outfit(
  id: 0,
  outfitImage: File(''),
  numOfLikes: 0,
  isLiked: false,
  description: '',
  totalPrice: 0.0,
  outfitComponents: [],
);

var mohamedImage = File('');

var greyImage = File('');

