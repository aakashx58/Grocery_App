import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';

import '../../../data/cart_items.dart';
import '../../../data/grocery_data.dart';
import '../../../data/wishlist_items.dart';
import '../models/home_product_data_models.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeProductWishListButtonClickedEvent>(
        homeProductWishListButtonClickedEvent);
    on<HomeProductCartButtonClickedEvent>(homeProductCartButtonClickedEvent);
    on<HomeWishListButtonNavigateEvent>(homeWishListButtonNavigateEvent);
    on<HomeCartButtonNavigateEvent>(homeCartButtonNavigateEvent);
  }
}

FutureOr<void> homeInitialEvent(
    HomeInitialEvent event, Emitter<HomeState> emit) async {
  emit(HomeLoadingState());
  await Future.delayed(Duration(seconds: 3));
  emit(
    HomeLoadedSuccessState(
      products: GroceryData.groceryProducts
          .map((e) => ProductDataModel(
                id: e['id'],
                name: e['name'],
                category: e['category'],
                price: e['price'],
                imageUrl: e['imageUrl'],
              ))
          .toList(),
    ),
  );
}

FutureOr<void> homeProductWishListButtonClickedEvent(
    HomeProductWishListButtonClickedEvent event, Emitter<HomeState> emit) {
  print('Wishlist product clicked');

  wishlistItems.add(event.clickedProduct);
  emit(HomeProductItemWishlistedActionState());
}

FutureOr<void> homeProductCartButtonClickedEvent(
    HomeProductCartButtonClickedEvent event, Emitter<HomeState> emit) {
  print('Cart product clicked');
  cartItems.add(event.clickedProduct);
  emit(HomeProductItemCartlistedActionState());
}

FutureOr<void> homeWishListButtonNavigateEvent(
    HomeWishListButtonNavigateEvent event, Emitter<HomeState> emit) {
  print('Wishlist Navigate clicked');
  emit(HomeNavigateToWishlistPageActionState());
}

FutureOr<void> homeCartButtonNavigateEvent(
    HomeCartButtonNavigateEvent event, Emitter<HomeState> emit) {
  print('Cart Navigate clicked');
  emit(HomeNavigateToCartPageActionState());
}
