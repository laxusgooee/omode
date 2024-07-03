import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';


class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/assets/images/welcome.jpg"),
                fit: BoxFit.cover
              ),
            ),
          ),
          SafeArea(
            child : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(top: 50, left: 10, right: 10),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'WELCOME TO\nOMODE',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 36,
                            height: 1.1,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'lorem ipsium valor et dolor',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 19,
                             
                          ),
                        )
                      ],
                    )
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 50),
                    child: PlatformElevatedButton(
                      padding: const EdgeInsets.only(left: 120, right: 120),
                      child: const Text(
                        'continue',
                        style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1)
                        ),
                      ),
                      onPressed: () => context.go('/login'),
                      material: (context, platform) => MaterialElevatedButtonData(
                        autofocus: true,
                        style: const ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll<Color>(Color.fromRGBO(66, 165, 245, 1.0)),
                        ),
                      ),
                      cupertino: (context, platform) => CupertinoElevatedButtonData(
                        color: const Color.fromRGBO(66, 165, 245, 1.0),
                        borderRadius:  const BorderRadius.all(Radius.circular(30))
                      ),
                    ),
                  )
                ]
              )
            )
          ),
        ],
      ),
    );
  }
}
