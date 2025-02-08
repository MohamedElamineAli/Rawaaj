import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rawaaj/cubit/add_product_cubit.dart';
import 'package:rawaaj/cubit/filter_cubit.dart';
import 'package:rawaaj/cubit/language_cubit.dart';
import 'package:rawaaj/cubit/location_cubit.dart';
import 'package:rawaaj/cubit/map_cubit.dart';
import 'package:rawaaj/cubit/profile_cubit.dart';
import 'package:rawaaj/databases/UserPreferences.dart';
import 'package:rawaaj/screens/home_screen.dart';
import 'package:rawaaj/screens/welcome_screen.dart';
import 'package:rawaaj/utils/account_utils.dart';
import 'cubit/account_cubit.dart';
import 'cubit/add_outfit_cubit.dart';
import 'cubit/create_account_cubit.dart';
import 'cubit/main_index_cubit.dart';
import 'cubit/outfit_cubit.dart';
import 'cubit/outfits_cubit.dart';
import 'cubit/product_cubit.dart';
import 'cubit/products_cubit.dart';
import 'cubit/shop_cubit.dart';
import 'cubit/shops_cubit.dart';
import 'constants/default_cubit_product.dart';
import 'databases/app_database.dart';
import 'themes/app_theme.dart';

Future<void> initImages() async {
  final db = AppDatabase.instance;

  mohamedImage = await db.getFileFromAsset('assets/images/mohamed.png');
  greyImage = await db.getFileFromAsset('assets/images/grey.png');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initImages();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider<MainIndexCubit>(
          create: (context) => MainIndexCubit(),
        ),
        BlocProvider<ProductsCubit>(
          create: (context) => ProductsCubit(),
        ),
        BlocProvider<ProductCubit>(
          create: (context) => ProductCubit(),
        ),
        BlocProvider<OutfitsCubit>(
          create: (context) => OutfitsCubit(),
        ),
        BlocProvider<OutfitCubit>(
          create: (context) => OutfitCubit(),
        ),
        BlocProvider<ShopsCubit>(
          create: (context) => ShopsCubit(),
        ),
        BlocProvider<ShopCubit>(
          create: (context) => ShopCubit(),
        ),
        BlocProvider<FilterCubit>(
          create: (context) => FilterCubit(),
        ),
        BlocProvider<LanguageCubit>(
          create: (context) => LanguageCubit(),
        ),
        BlocProvider<LocationCubit>(
          create: (context) => LocationCubit(),
        ),
        BlocProvider<ProfileCubit>(
          create: (context) => ProfileCubit(),
        ),
        BlocProvider<AddProductCubit>(
          create: (context) => AddProductCubit(defaultCubitProduct),
        ),
        BlocProvider<AddOutfitCubit>(
          create: (context) => AddOutfitCubit(defaultCubitOutfit),
        ),
        BlocProvider<CreateAccountCubit>(
          create: (context) => CreateAccountCubit(),
        ),
        BlocProvider<MapCubit>(
          create: (context) => MapCubit(),
        ),
        BlocProvider<AccountCubit>(
          create: (context) => AccountCubit(),
        ),
      ],

      child: MaterialApp(
        home: BlocBuilder<AccountCubit, AccountState>(
          builder: (context, state) {
            context.read<AccountCubit>().loadAccountInfo();

            if (state is AccountLoading) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            } else if (state is AccountSuccess) {
              return state.isLoggedIn ? const HomeScreen() : const WelcomeScreen();
            } else {
              return const WelcomeScreen();
            }
          },
        ),
        theme: appTheme,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}