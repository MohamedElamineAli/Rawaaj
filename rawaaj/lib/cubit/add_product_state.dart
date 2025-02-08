part of 'add_product_cubit.dart';

class AddProductState extends Equatable {
  final Product product;
  final bool isLoading;

  const AddProductState({required this.product, this.isLoading = false});

  AddProductState copyWith({
    int? id,
    List<File>? images,
    int? categoryId,
    double? price,
    bool? isLiked,
    String? description,
    List<String>? variation,
    double? totalRatings,
    List<Review>? reviews,
    List<String>? materials,
    String? origin,
    List<int>? sizes,
    List<int>? colors,
    int? shopId,
  }) {
    return AddProductState(
      product: product.copyWith(
        id: id,
        images: images,
        categoryId: categoryId,
        price: price,
        isLiked: isLiked,
        description: description,
        variation: variation,
        totalRatings: totalRatings,
        reviews: reviews,
        materials: materials,
        origin: origin,
        sizes: sizes,
        colors: colors,
        shopId: shopId,
      ),
    );
  }

  @override
  List<Object> get props => [product, isLoading];
}
