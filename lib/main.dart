import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

// import 'package:flutter/rendering.dart';

import './pages/auth.dart';
import './pages/selectingTypeOfAccountPage.dart';
import './pages/signuppage1.dart';
import './pages/signuppage2.dart';
import './pages/signuppage3.dart';
import './pages/organizationsignuppage1.dart';
import './pages/organizationsignuppage2.dart';
import './pages/organizationsignuppage3.dart';
import './pages/loginpage.dart';
import './pages/cameraMain.dart';
import './pages/cameraPage.dart';
import './pages/imageTaken.dart';
import './pages/initialDiagnoses.dart';
import './pages/products_admin.dart';
import './pages/products.dart';
import './pages/product.dart';
import './scoped-models/main.dart';
import 'scoped-models/inherited_state.dart';
import './models/product.dart';
import './models/camera.dart';

void main() {
  // debugPaintSizeEnabled = true;
  // debugPaintBaselinesEnabled = true;
  // debugPaintPointersEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final MainModel model = MainModel();
    return ScopedModel<MainModel>(
      model: model,
      child: AppStateContainer(child:MaterialApp(
        // debugShowMaterialGrid: true,
        theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.lightBlue,
            accentColor: Colors.blue,
            buttonColor: Colors.lightBlue[600]),
        // home: AuthPage(),
        routes: {
          '/': (BuildContext context) => AuthPage(),
          '/accounttype': (BuildContext context) => AccountType(),
          '/signuppage1': (BuildContext context) => SignUpPage(),
          '/signuppage2': (BuildContext context) => SignUpPage2(user: 'No value was passed through'),
          '/signuppage3': (BuildContext context) => SignUpPage3(user: 'No value was passed through'),
          '/organizationsignuppage1': (BuildContext context) => OrganizationSignUpPage(),
          '/organizationsignuppage2': (BuildContext context) => OrganizationSignUpPage2( user: 'No value was passed through' ),
          '/organizationsignuppage3': (BuildContext context) => OrganizationSignUpPage3( user: 'No value was passed through' ),
          '/results': (BuildContext context) => ImageTaken(),
          '/loginpage': (BuildContext context) => LogInPage(),
          '/cameraMain': (BuildContext context) => CameraApp(),
          '/cameraPage': (BuildContext context) => CameraPage(availablecameras: gCamData.availableCameras ,),
          '/products': (BuildContext context) => ProductsPage(model),
          '/admin': (BuildContext context) => ProductsAdminPage(model),
        },
        onGenerateRoute: (RouteSettings settings) {
          final List<String> pathElements = settings.name.split('/');
          if (pathElements[0] != '') {
            return null;
          }
          if (pathElements[1] == 'product') {
            final String productId = pathElements[2];
            print("In the if statement");
            final Product product = model.allProducts.firstWhere((Product product) {
              return product.id == productId;
            });
            return MaterialPageRoute<bool>(
              builder: (BuildContext context) => ProductPage(product),
            );
          }
          return null;
        },
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(
              builder: (BuildContext context) => ProductsPage(model));
        },
      ),),
    );
  }
}
