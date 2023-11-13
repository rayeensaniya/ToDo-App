import 'package:flutter/material.dart';
import 'package:todo_app/screens/add_screen.dart';
import 'package:todo_app/widget/app_card.dart';

import '../bloc/dashboard_bloc.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final dashBloc = DashboardBloc();

  @override
  void dispose() {
    super.dispose();
    dashBloc.isChecked.close();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          floatingActionButton: StreamBuilder<bool>(
              stream: dashBloc.isHideFab,
              builder: (context, snapshot) {
                if (snapshot.data == true) {
                  return const SizedBox();
                } else {
                  return FloatingActionButton(
                    backgroundColor: Colors.black,
                    child: const Icon(Icons.add, color: Colors.white),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddScreen(),
                          ));
                    },
                  );
                }
              }),
          appBar: AppBar(
            bottom: const TabBar(labelColor: Colors.white, tabs: [
              Text('Completed'),
              Text('Pending'),
            ]),
            backgroundColor: Colors.black,
            title: const Center(
              child: Text('DASHBOARD',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
          body: TabBarView(children: [
            AppCard(dashboardBloc: dashBloc),
            AppCard(dashboardBloc: dashBloc),
          ])),
    );
  }
}
