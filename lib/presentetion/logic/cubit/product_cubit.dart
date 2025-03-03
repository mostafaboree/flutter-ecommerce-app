// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:weather_app/data/modal/product/product.dart';
import 'package:weather_app/data/remote/api_response.dart';
import 'package:weather_app/data/repo.dart';
import 'package:weather_app/presentetion/logic/product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final Repo _productRepository;
  List<ProductModel> _allProducts = [];
  ProductCubit(this._productRepository) : super(ProductInitial());

 Future<void> getAllProduct() async {
    emit(ProductLoading());
    final response = await _productRepository.getAllProduct();
    if (response is SuccessResponse<List<ProductModel>>) {
      _allProducts= response.data;
      emit( ProductLoaded(response.data));
    } else {
      emit( ProductError("Error fetching data"));
    }
  }
  void searchProducts(String query) {
    if (query.isEmpty) {
      emit(ProductLoaded(_allProducts)); // Show all products if the query is empty
    } else {
      final filteredProducts = _allProducts
          .where((product) =>
          product.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
      emit(ProductLoaded(filteredProducts));
    }
  }

  
}
