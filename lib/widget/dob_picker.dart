import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class DOBInput extends StatefulWidget {
  const DOBInput({
    super.key,
    required this.callBack,
  });

  final Function(DateTime) callBack;

  @override
  State<DOBInput> createState() => _DOBInputState();
}

class _DOBInputState extends State<DOBInput>
    with AutomaticKeepAliveClientMixin {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    DateTime? now = DateTime.now();

    Future<void> selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1950, 8),
        lastDate: DateTime(now.year - 18, now.month, now.day - 1),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              // useMaterial3: true,
              applyElevationOverlayColor: false,
              colorScheme: const ColorScheme.dark(
                // background: Colors.black,
                primary: Colors.white,
                onPrimary: Colors.black,
                onSurface: Colors.white,
              ),
              textTheme: TextTheme(),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                ),
              ),
            ),
            child: child!,
          );
        },
      );
      //print(picked);
      if (picked != null && picked != selectedDate) {
        setState(() {
          selectedDate = picked;
        });
        widget.callBack.call(picked);
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'What’s your birth date',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(const Color(0xff111111)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
                side: const BorderSide(
                  color: Color(0xff404040),
                ),
              ),
            ),
          ),
          onPressed: () {
            selectDate(context);
          },
          child: Builder(builder: (context) {
            //parse selected text
            String formattedDate = 'DD MM YYYY';
            if (selectedDate != null) {
              formattedDate = DateFormat('dd MM yyyy').format(selectedDate!);
            }
            //print(selectedDate);
            return Padding(
              padding: const EdgeInsets.all(14.0),
              child: Text(
                formattedDate,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontSize: 16),
              ),
            );
          }),
        ),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
