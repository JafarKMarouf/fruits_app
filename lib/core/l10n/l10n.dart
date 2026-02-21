// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class AppLocalizations {
  AppLocalizations();

  static AppLocalizations? _current;

  static AppLocalizations get current {
    assert(
      _current != null,
      'No instance of AppLocalizations was loaded. Try to initialize the AppLocalizations delegate before accessing AppLocalizations.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<AppLocalizations> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = AppLocalizations();
      AppLocalizations._current = instance;

      return instance;
    });
  }

  static AppLocalizations of(BuildContext context) {
    final instance = AppLocalizations.maybeOf(context);
    assert(
      instance != null,
      'No instance of AppLocalizations present in the widget tree. Did you add AppLocalizations.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static AppLocalizations? maybeOf(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  /// `Welcome to `
  String get onBoardingWelcomeTitle {
    return Intl.message(
      'Welcome to ',
      name: 'onBoardingWelcomeTitle',
      desc: '',
      args: [],
    );
  }

  /// `Discover a unique shopping experience with FruitHUB. Explore our wide selection of premium fresh fruits and get the best deals with high quality.`
  String get onBoardingWelcomeSubTitle {
    return Intl.message(
      'Discover a unique shopping experience with FruitHUB. Explore our wide selection of premium fresh fruits and get the best deals with high quality.',
      name: 'onBoardingWelcomeSubTitle',
      desc: '',
      args: [],
    );
  }

  /// `Search & Shop`
  String get onBoardingSearchTitle {
    return Intl.message(
      'Search & Shop',
      name: 'onBoardingSearchTitle',
      desc: '',
      args: [],
    );
  }

  /// `We offer you the best carefully selected fruits. Check details, photos and reviews to ensure you choose the perfect fruit.`
  String get onBoardingSearchSubTitle {
    return Intl.message(
      'We offer you the best carefully selected fruits. Check details, photos and reviews to ensure you choose the perfect fruit.',
      name: 'onBoardingSearchSubTitle',
      desc: '',
      args: [],
    );
  }

  /// `Start Now`
  String get startNowButton {
    return Intl.message(
      'Start Now',
      name: 'startNowButton',
      desc: '',
      args: [],
    );
  }

  /// `skip`
  String get skip {
    return Intl.message('skip', name: 'skip', desc: '', args: []);
  }

  /// `Log in`
  String get loginTitle {
    return Intl.message('Log in', name: 'loginTitle', desc: '', args: []);
  }

  /// `Sign up`
  String get signupTitle {
    return Intl.message('Sign up', name: 'signupTitle', desc: '', args: []);
  }

  /// `Full Name`
  String get fullName {
    return Intl.message('Full Name', name: 'fullName', desc: '', args: []);
  }

  /// `Email Address`
  String get emailAddress {
    return Intl.message(
      'Email Address',
      name: 'emailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `?forget password`
  String get forgetPassword {
    return Intl.message(
      '?forget password',
      name: 'forgetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Dont have an account? `
  String get dontHaveAccount {
    return Intl.message(
      'Dont have an account? ',
      name: 'dontHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Create account`
  String get doCreateAccount {
    return Intl.message(
      'Create account',
      name: 'doCreateAccount',
      desc: '',
      args: [],
    );
  }

  /// `Or`
  String get or {
    return Intl.message('Or', name: 'or', desc: '', args: []);
  }

  /// `Login with Google`
  String get loginByGoogle {
    return Intl.message(
      'Login with Google',
      name: 'loginByGoogle',
      desc: '',
      args: [],
    );
  }

  /// `Login with Apple`
  String get loginByApple {
    return Intl.message(
      'Login with Apple',
      name: 'loginByApple',
      desc: '',
      args: [],
    );
  }

  /// `Login with Facebook`
  String get loginByFacebook {
    return Intl.message(
      'Login with Facebook',
      name: 'loginByFacebook',
      desc: '',
      args: [],
    );
  }

  /// `By creating an account, you agree to `
  String get byCreatingAccount {
    return Intl.message(
      'By creating an account, you agree to ',
      name: 'byCreatingAccount',
      desc: '',
      args: [],
    );
  }

  /// `Our Terms and Conditions`
  String get termsAndConditions {
    return Intl.message(
      'Our Terms and Conditions',
      name: 'termsAndConditions',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account? `
  String get alreadyHaveAccount {
    return Intl.message(
      'Already have an account? ',
      name: 'alreadyHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `The password provided is too weak.`
  String get weakPassword {
    return Intl.message(
      'The password provided is too weak.',
      name: 'weakPassword',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong. Please try again later.`
  String get genericError {
    return Intl.message(
      'Something went wrong. Please try again later.',
      name: 'genericError',
      desc: '',
      args: [],
    );
  }

  /// `Network request failed. Please check your internet connection.`
  String get networkRequestFailed {
    return Intl.message(
      'Network request failed. Please check your internet connection.',
      name: 'networkRequestFailed',
      desc: '',
      args: [],
    );
  }

  /// `The email address is invalid.`
  String get invalidEmail {
    return Intl.message(
      'The email address is invalid.',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `You must agree to the terms and conditions`
  String get termsAcceptedError {
    return Intl.message(
      'You must agree to the terms and conditions',
      name: 'termsAcceptedError',
      desc: '',
      args: [],
    );
  }

  /// `Email or password invalid.`
  String get invalidCredential {
    return Intl.message(
      'Email or password invalid.',
      name: 'invalidCredential',
      desc: '',
      args: [],
    );
  }

  /// `Registered account successfully!`
  String get registerSuccess {
    return Intl.message(
      'Registered account successfully!',
      name: 'registerSuccess',
      desc: '',
      args: [],
    );
  }

  /// `This field is required`
  String get requiredField {
    return Intl.message(
      'This field is required',
      name: 'requiredField',
      desc: '',
      args: [],
    );
  }

  /// `Logged in successfully!`
  String get loginSuccess {
    return Intl.message(
      'Logged in successfully!',
      name: 'loginSuccess',
      desc: '',
      args: [],
    );
  }

  /// `The account already exists for that email.`
  String get emailAlreadyInUse {
    return Intl.message(
      'The account already exists for that email.',
      name: 'emailAlreadyInUse',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get homeTitle {
    return Intl.message('Home', name: 'homeTitle', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
