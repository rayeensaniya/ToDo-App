import 'package:flutter/material.dart';
import 'package:todo_app/local_helper/preference_helper.dart';
import 'package:todo_app/modals/todo_modal.dart';
import 'package:todo_app/modals/user_modal.dart';
import 'package:todo_app/screens/add_screen.dart';
import 'package:todo_app/screens/log_in.dart';
import 'package:todo_app/widget/app_card.dart';

import '../bloc/dashboard_bloc.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List<TodoModel> notesList = [];

  final dashBloc = DashboardBloc();

  @override
  void initState() {
    super.initState();

    /// Fetching Notes from Database
    dashBloc.fetchData();
  }

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
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                child: Column(
                  children: [
                    const Icon(
                      Icons.person,
                      color: Colors.black,
                      size: 80,
                    ),
                    FutureBuilder<User?>(
                      future: SharedPreferencesHelper.getUser(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                            children: [
                              Text('NAME : ${snapshot.data?.name}'),
                              Text('EMAIL : ${snapshot.data?.email}')
                            ],
                          );
                        } else {
                          return const Text('No data available');
                        }
                      },
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.logout_sharp,
                  ),
                  TextButton(
                    onPressed: () async {
                      await SharedPreferencesHelper.clearUser();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LogIn(),
                          ));
                    },
                    child: const Text(
                      'Log Out',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.settings,
                  ),
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        ' Settings',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      )),
                ],
              )
            ],
          ),
        ),
        floatingActionButton: StreamBuilder<bool>(
            stream: dashBloc.isHideFab,
            builder: (context, snapshot) {
              if (snapshot.data == true) {
                return const SizedBox();
              } else {
                return FloatingActionButton(
                  backgroundColor: Colors.black,
                  child: const Icon(Icons.add, color: Colors.white),
                  onPressed: () async {
                    final refresh = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddScreen(),
                      ),
                    );
                    if (refresh == true) {
                      dashBloc.fetchData();
                    }
                  },
                );
              }
            }),
        appBar: AppBar(
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white),
          bottom: const TabBar(labelColor: Colors.white, tabs: [
            Text('Completed'),
            Text('Pending'),
          ]),
          backgroundColor: Colors.black,
          title: const Text(
            'DASHBOARD',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: TabBarView(
          children: [
            StreamBuilder<List<TodoModel>>(
                stream: dashBloc.completedTodo,
                builder: (context, snapshot) {
                  return AppCard(
                    dashboardBloc: dashBloc,
                    listTodo: snapshot.data ?? [],
                  );
                }),
            StreamBuilder<List<TodoModel>>(
                stream: dashBloc.pendingTodoList,
                builder: (context, snapshot) {
                  return AppCard(
                    dashboardBloc: dashBloc,
                    listTodo: snapshot.data ?? [],
                  );
                }),
          ],
        ),
      ),
    );
  }
}
