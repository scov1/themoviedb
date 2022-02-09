import 'package:flutter/material.dart';
import 'package:themoviedb/Library/Widgets/inherited/provider.dart';
import 'package:themoviedb/Theme/button_style.dart';
import 'package:themoviedb/widgets/auth/auth_model.dart';

class AuthWidget extends StatefulWidget {
  @override
  _AuthWidgetState createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login to your account'),
      ),
      body: ListView(
        children: [_HeaderWidget()],
      ),
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 25,
          ),
          _FormWidget(),
          SizedBox(
            height: 25,
          ),
          Text(
              'In order to use the editing and rating capabilities of TMDB, as well as get personal recommendations you will need to login to your account. If you do not have an account, registering for an account is free and simple. Click here to get started',
              style: TextStyle(fontSize: 16, color: Colors.black)),
          SizedBox(
            height: 5,
          ),
          TextButton(
              onPressed: () {},
              style: AppButtonStyle.linkButton,
              child: Text('Register')),
          SizedBox(
            height: 25,
          ),
          Text(
              'If you signed up but didn`t get your verification email, click here to have it resent',
              style: TextStyle(fontSize: 16, color: Colors.black)),
          TextButton(
              onPressed: () {},
              style: AppButtonStyle.linkButton,
              child: Text('Verify email')),
        ],
      ),
    );
  }
}

class _FormWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final model = NotifierProvider.read<AuthModel>(context);
    final textStyle = const TextStyle(fontSize: 16, color: Color(0xFF212529));
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ErrorMessageWidget(),
        Text(
          'Username',
          style: textStyle,
        ),
        SizedBox(
          height: 5,
        ),
        TextField(
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              isCollapsed: true,
              focusColor: Color(0xFF01B4E4)),
          controller: model?.loginTextController,
        ),
        SizedBox(
          height: 25,
        ),
        Text(
          'Password',
          style: textStyle,
        ),
        SizedBox(
          height: 5,
        ),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            isCollapsed: true,
            focusColor: Color(0xFF01B4E4),
          ),
          obscureText: true,
          controller: model?.passwordTextController,
        ),
        SizedBox(height: 25),
        Row(
          children: [
            _AuthButtonWidget(),
            SizedBox(
              width: 30,
            ),
            TextButton(
              onPressed: (){},
              style: AppButtonStyle.linkButton,
              child: Text('Reset password'),
            ),
          ],
        )
      ],
    );
  }
}

class _AuthButtonWidget extends StatelessWidget {
  const _AuthButtonWidget({
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = const Color(0xFF01B4E4);
    final model = NotifierProvider.watch<AuthModel>(context);

    return ElevatedButton(
      onPressed: model?.canStartAuth == true ? () => model?.auth(context) : null,
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(color),
          foregroundColor: MaterialStateProperty.all(Colors.white),
          textStyle: MaterialStateProperty.all(
            TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          padding: MaterialStateProperty.all(
              EdgeInsets.symmetric(horizontal: 15, vertical: 8))),
      child: model?.canAuthProgress == true ? SizedBox(width: 15,height:15, child: CircularProgressIndicator()) : Text('Login'),
    );
  }
}

class _ErrorMessageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final errorMessage = NotifierProvider.watch<AuthModel>(context)?.errorMessage;
    if(errorMessage == null)return SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom:20.0),
      child: Text(errorMessage, style: TextStyle(color: Colors.red, fontSize: 17)),
    );
  }
}