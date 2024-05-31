import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:supportu_flutter_app/data/user.dart';
// import 'package:sparq_data/sparq_data.dart';

class GenderOption {
  final Gender gender;
  final String genderTitle;

  GenderOption({required this.gender, required this.genderTitle});
}

class GenderPicker extends StatefulWidget {
  const GenderPicker({
    super.key,
    required this.callBack,
  });
  final Function(Gender) callBack;

  @override
  State<GenderPicker> createState() => _GenderPickerState();
}

class _GenderPickerState extends State<GenderPicker>
    with AutomaticKeepAliveClientMixin {
  final List<GenderOption> genderList = [
    GenderOption(gender: Gender.male, genderTitle: 'Male'),
    GenderOption(gender: Gender.female, genderTitle: 'Female'),
    GenderOption(gender: Gender.other, genderTitle: 'I prefer not to say')
  ];
  GenderOption? selectedOption;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    // DateTime? now = DateTime.now();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'Tell us how do you identify',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 50,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            // physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              bool isSelected = genderList[index] == selectedOption;
              return Padding(
                padding: const EdgeInsets.all(2.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xff111111)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        side: BorderSide(
                          color: isSelected
                              ? Colors.white
                              : const Color(0xff404040),
                        ),
                      ),
                    ),
                  ),
                  onPressed: () {
                    // selectDate(context);
                    setState(() {
                      selectedOption = genderList[index];
                      widget.callBack.call(genderList[index].gender);
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      genderList[index].genderTitle,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontSize: 16),
                    ),
                  ),
                ),
              );
            },
            itemCount: genderList.length,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
