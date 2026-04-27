import 'package:flutter/material.dart';

import '../../../commons/widgets/buttons/elevated_button.dart';

class CreateReportButton extends StatelessWidget {
  const CreateReportButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: UElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, '/createReport');
        },
        child: Text(
          'Find an Issue? Create Report',
          style: TextStyle(letterSpacing: 0.5),
        ),
      ),
    );
  }
}