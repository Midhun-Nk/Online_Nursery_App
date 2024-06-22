import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:online_nursery_plant_shop/bindings/general_bindings.dart';
import 'package:online_nursery_plant_shop/utils/constants/colors.dart';
import 'package:online_nursery_plant_shop/utils/constants/text_strings.dart';
import 'package:online_nursery_plant_shop/utils/theme/theme.dart';


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: TTexts.appName,
      themeMode: ThemeMode.system,
      initialBinding: GeneralBindings(),
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      // initialBinding: GeneralBindings(),
      home:const  Scaffold(
        backgroundColor: TColors.primary,
        body: Center(child: CircularProgressIndicator(
          color: Colors.white,
        ),),
      )
    );
  }
}
