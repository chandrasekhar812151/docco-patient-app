import 'package:doctor_patient/bloc/service_locator.dart';
import 'package:doctor_patient/bloc/slots_bloc.dart';
import 'package:doctor_patient/resources/repository.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_chips_input/flutter_chips_input.dart';

class Symptoms extends StatefulWidget {
  @override
  _SymptomsState createState() => _SymptomsState();
}

class _SymptomsState extends State<Symptoms> {
  @override
  Widget build(BuildContext context) {
    final bloc = sl<SlotsBloc>();

    return StreamBuilder<SlotsModel>(
        stream: bloc.slots,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return LinearProgressIndicator();
          }

          return Text("test");

          // return ChipsInput(
          //   initialValue: [],
          //   decoration: InputDecoration(
          //     labelText: "Symptoms",
          //     border: OutlineInputBorder()
          //   ),
          //   maxChips: 10,
          //   findSuggestions: (String query) async {
          //     if (query.length != 0) {
          //       var lowercaseQuery = query.toLowerCase();
          //       var list = await Repository.getSymptoms(lowercaseQuery);
          //       if (list.length == 0) {
          //         return [query];
          //       }
          //
          //       return list;
          //     } else {
          //       print('No symptoms found');
          //       return [];
          //     }
          //   },
          //   onChanged: (data) {
          //     List<String> list = data.map((d) => d.toString()).toList();
          //     bloc.updateSymptoms(list.join(','));
          //     print(data);
          //   },
          //   chipBuilder: (context, state, symptom) {
          //     return InputChip(
          //       key: ObjectKey(symptom),
          //       label: Text(symptom.toString()),
          //       onDeleted: () => state.deleteChip(symptom),
          //       materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          //     );
          //   },
          //   suggestionBuilder: (context, state, symptom) {
          //     return ListTile(
          //       key: ObjectKey(symptom),
          //       title: Text(symptom.toString()),
          //       onTap: () => state.selectSuggestion(symptom),
          //     );
          //   },
          // );
        });
  }
}
