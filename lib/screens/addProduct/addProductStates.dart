
abstract class AddProductStates {}
class AddProductInitialState extends AddProductStates {}
class AddProductLoadingState extends AddProductStates {}
class AddProductSuccessState extends AddProductStates {}
class AddProductErrorState extends AddProductStates {
  String error;
  AddProductErrorState(this.error);
}
class CatLoadingState extends AddProductStates {}
class CatSuccessState extends AddProductStates {}
class CatErrorState extends AddProductStates {
  String error;
  CatErrorState(this.error);
}
class AddShowMessageState extends AddProductStates {}
class ImageState extends AddProductStates {}