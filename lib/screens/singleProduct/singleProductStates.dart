
abstract class SingleProductStates {}
class SingleProductInitialState extends SingleProductStates {}
class SingleProductLoadingState extends SingleProductStates {}
class SingleProductSuccessState extends SingleProductStates {}
class SingleProductErrorState extends SingleProductStates {
  String error;
  SingleProductErrorState(this.error);
}
class LoginShowMessageState extends SingleProductStates {}
class SingleProductShowMessageState extends SingleProductStates{}