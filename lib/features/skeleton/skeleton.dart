import 'package:eva_life_care/features/list_appointment/presentation/pages/list_appointment_page.dart';
import 'package:flutter/material.dart';
import '../pokemon/presentation/pages/data_page.dart';
import 'package:provider/provider.dart';
import 'widgets/custom_bottom_bar_widget.dart';
import 'providers/selected_page_provider.dart';

List<Widget> pages = const [
  ListAppointmentPage(),
  DataPage(),
];

class Skeleton extends StatelessWidget {
  const Skeleton({super.key});

  @override
  Widget build(BuildContext context) {
    int selectedPage = Provider.of<SelectedPageProvider>(context).selectedPage;
    return Scaffold(
      body: pages[selectedPage],
      bottomNavigationBar: const CustomBottomBarWidget(),
    );
  }
}
