import 'package:flutter/material.dart';
import 'package:lumina_frontend/core/themes/main_theme.dart';
import 'package:lumina_frontend/features/_account_home_manager/stats/presentation/widget/name_box.dart';

import 'package:lumina_frontend/services/integration_Funcs.dart';
import 'package:lumina_frontend/model/models.dart';

class DropDown extends StatefulWidget {
  final VoidCallback onToggleDropDown;

  const DropDown({super.key, required this.onToggleDropDown});

  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  final ScrollController _scrollController = ScrollController();
  var instance = Integration();
  List<TopLevelHome> homes = [];

  @override
  void initState() {
    super.initState();
    getHomeOwnerData();
  }

  void getHomeOwnerData() async {
    List<TopLevelHome> tlh = await instance.getallTopLevelHomes();
    if (tlh.isNotEmpty) {
      TopLevelHome home = tlh[0];
      setState(() {
        homes = tlh;
      });
    } else {
      print("No top level homes found.");
    }
  }

  @override
  Widget build(BuildContext context) {
    getHomeOwnerData();

    return FractionallySizedBox(
      widthFactor: 0.9,
      heightFactor: 0.9,
      child: Container(
        padding: const EdgeInsets.all(36.0),
        decoration: BoxDecoration(
          color: Colors.white
              .withValues(alpha: 10), // Use withOpacity instead of withValues
          borderRadius: BorderRadius.circular(10), // Rounded edges
        ),
        child: Row(
          children: [
            Expanded(
              flex: 85, // Take up 85% of the space
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Your Homes',
                          style: MainTheme.h1Black,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Scrollbar(
                      controller: _scrollController,
                      thumbVisibility: true,
                      trackVisibility: true,
                      thickness: 8.0,
                      radius: const Radius.circular(10),
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: homes.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: NameBox(
                                    name: homes[index].name,
                                    onToggleDropDown: widget.onToggleDropDown,
                                  ),
                                ),
                                const SizedBox(
                                  width:
                                      16, // Add space between NameBox and scrollbar
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
