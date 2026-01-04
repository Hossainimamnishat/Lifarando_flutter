part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const SPLASH = _Paths.SPLASH;
  static const AUTH = _Paths.AUTH;
  static const HOME = _Paths.HOME;
  static const RESTAURANT = _Paths.RESTAURANT;
  static const CART = _Paths.CART;
  static const CHECKOUT = _Paths.CHECKOUT;
  static const PROFILE = _Paths.PROFILE;
  static const SEARCH = _Paths.SEARCH;
  static const ORDERS = _Paths.ORDERS;
}

abstract class _Paths {
  _Paths._();
  static const SPLASH = '/splash';
  static const AUTH = '/auth';
  static const HOME = '/home';
  static const RESTAURANT = '/restaurant';
  static const CART = '/cart';
  static const CHECKOUT = '/checkout';
  static const PROFILE = '/profile';
  static const SEARCH = '/search';
  static const ORDERS = '/orders';
}

