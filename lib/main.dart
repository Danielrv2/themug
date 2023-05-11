import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_app/src/models/user_model.dart';
import 'package:second_app/src/routing/Login/signup.dart';
import 'package:second_app/src/routing/login/login.dart';
import 'package:second_app/src/routing/main_client/main_client.dart';
import 'package:second_app/src/routing/welcome.dart';
import 'package:second_app/src/services/notifications.services.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await intializeNotifications();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_)=> ReadUserCubit(ReadUser(userModel: UserModel.empty())),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Mug Bistro',
          theme: ThemeData(
            primaryColor: const Color.fromRGBO(25, 60, 52, 1),
            fontFamily: 'Montserrat',
          ),
          home: const WelcomeScreen(),
          routes: {
            'welcome': ((context)=> const WelcomeScreen()),
            'login': ((context)=> LoginScreen()),
            'signUp': ((context)=> SingUpScreen()),
            'main': ((context)=> const MainClient()),
          },
        ),
    );
  }
}

class ReadUser{
  UserModel userModel;
  ReadUser({required this.userModel});
}

void onSetInfoUser(UserModel userModel,BuildContext context){
  var infoUser = context.read<ReadUserCubit>();
  infoUser.setUser(userModel);
}

class ReadUserCubit extends Cubit<ReadUser>{
  ReadUserCubit(ReadUser initialState): super(initialState);

  void setUser(UserModel userModel){
    emit(ReadUser(userModel: userModel));
  }
}


