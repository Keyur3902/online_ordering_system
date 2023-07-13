import '../../../../Data/favoriteDataModel.dart';

abstract class FavouriteState {}

class FavouriteLoadingState extends FavouriteState {}

class FavouriteLoadedState extends FavouriteState {
  final List<FavoriteData> favoriteProduct;
  FavouriteLoadedState(this.favoriteProduct);
}

class FavouriteErrorState extends FavouriteState {
  final String errorMessage;
  FavouriteErrorState(this.errorMessage);
}

class FavouriteFailedState extends FavouriteState {}

class FavouriteEmptyState extends FavouriteState {}

class AddToFavouriteLoadingState extends FavouriteState {}

class AddToFavouriteSuccessState extends FavouriteState {}

class AddToFavouriteFailedState extends FavouriteState {}

class RemoveFromFavouriteLoadingState extends FavouriteState {}

class RemoveFromFavouriteSuccessState extends FavouriteState {}

class RemoveFromFavouriteFailedState extends FavouriteState {}