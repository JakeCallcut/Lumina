import 'package:flutter/material.dart';
import 'package:lumina_frontend/core/themes/main_theme.dart';
import 'package:lumina_frontend/features/_account_home_manager/stats/presentation/widget/name_box.dart';
import 'package:lumina_frontend/services/integration_Funcs.dart';
import 'package:lumina_frontend/model/models.dart';
import 'package:provider/provider.dart';
import 'package:lumina_frontend/providers/providers.dart';

class DropDown extends StatefulWidget {
  final VoidCallback onToggleDropDown;
  final String tlhID;

  const DropDown({super.key, required this.onToggleDropDown, required this.tlhID});

  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  final ScrollController _scrollController = ScrollController();
  var instance = Integration();
  late final String tlhID = widget.tlhID;

  @override
  Widget build(BuildContext context) {
    final house = Provider.of<homeProvider>(context, listen: false);
    return FutureBuilder<List<Household>>(
      future: Future.value(house.houseHolds),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No top level homes found.'));
        } else {
          List<Household> homes = snapshot.data!;
          return FractionallySizedBox(
            widthFactor: 0.9,
            heightFactor: 0.9,
            child: Container(
              padding: const EdgeInsets.all(36.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 10), // Use withOpacity instead of withValues
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
                                          name: homes[index].homeDetails['address'] ?? 'Unknown',
                                          onToggleDropDown: widget.onToggleDropDown,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 16, // Add space between NameBox and scrollbar
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
      },
    );
  }
}