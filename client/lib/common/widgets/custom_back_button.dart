import 'package:client/core/theme/pallete.dart';
import 'package:client/features/home/view/pages/home_page.dart';
import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  final bool isAuth;
  const CustomBackButton({super.key, this.isAuth = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      child: PhysicalModel(
        color: theme.colorScheme.surfaceContainerLow,
        shadowColor: Colors.black.withOpacity(0.4),
        elevation: 6,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          onTap: () {
            if (isAuth) {
              Navigator.pushReplacementNamed(context, '/home');
            } else {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              } else {
                final currentRoute = ModalRoute.of(context)?.settings.name;
                if (currentRoute != '/home' && currentRoute != '/chat') {
                  Navigator.pushReplacement(
                    context, 
                    MaterialPageRoute(builder: (context) => HomePage())
                  );
                }
              }
            }
          },
          borderRadius: BorderRadius.circular(18),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Icon(Icons.arrow_back_ios_outlined)
          ),
        ),
      ),
    );
  }
}

