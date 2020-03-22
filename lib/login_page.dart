import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordFocusNode = FocusNode();

  String animationType = "idle";

  @override
  initState() {
    _passwordFocusNode.addListener(() {
      if (_passwordFocusNode.hasFocus) {
        setState(() {
          animationType = "cover_eyes_in";
        });
      } else {
        if (animationType == "cover_eyes_in") {
          setState(() {
            animationType = "cover_eyes_out";
          });
        }
      }
    });
    super.initState();
  }

  Widget _buildBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [0.0, 1.0],
          colors: [
            Color.fromRGBO(170, 207, 211, 1.0),
            Color.fromRGBO(93, 142, 155, 1.0),
          ],
        ),
      ),
    );
  }

  Widget _buildGuss() {
    return Container(
      height: 200,
      padding: EdgeInsets.only(left: 30.0, right: 30.0),
      child: FlareActor(
        "assets/Guss.flr",
        shouldClip: false,
        alignment: Alignment.topCenter,
        fit: BoxFit.cover,
        animation: animationType,
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _buildEmailTextFormField(),
          _buildPasswordTextFormField(),
          _buildSubmitButton(),
        ],
      ),
    );
  }

  Widget _buildEmailTextFormField() {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: "Email",
          hintText: "What's your email address?",
        ),
        controller: _emailController,
      ),
    );
  }

  Widget _buildPasswordTextFormField() {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          labelText: "Password",
          hintText: "Try 'Guss'...",
        ),
        controller: _passwordController,
        focusNode: _passwordFocusNode,
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Container(
      width: double.infinity,
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        gradient: LinearGradient(
          colors: <Color>[
            Color.fromRGBO(160, 92, 147, 1.0),
            Color.fromRGBO(115, 82, 135, 1.0)
          ],
        ),
      ),
      child: InkWell(
        child: Center(
          child: Text(
            'Sign In',
            style: TextStyle(
              fontFamily: "RobotoMedium",
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
        onTap: () {
          if (_passwordController.text == "guss") {
            setState(() {
              animationType = "success";
            });
          } else {
            setState(() {
              animationType = "fail";
            });
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    EdgeInsets devicePadding = MediaQuery.of(context).padding;
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
          if (animationType == "cover_eyes_in") {
            setState(() {
              animationType = "cover_eyes_out";
            });
          } else {
            setState(() {
              animationType = "idle";
            });
          }
        },
        child: Stack(
          children: <Widget>[
            _buildBackground(),
            Positioned.fill(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  top: devicePadding.top + 50.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    _buildGuss(),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(30.0),
                        child: _buildForm(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
