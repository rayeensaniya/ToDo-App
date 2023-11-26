import 'package:flutter/material.dart';
import 'package:todo_app/bloc/dashboard_bloc.dart';
import 'package:todo_app/screens/add_screen.dart';

import '../modals/todo_modal.dart';

class AppCard extends StatefulWidget {
  const AppCard({Key? key, required this.dashboardBloc, required this.listTodo})
      : super(key: key);
  final DashboardBloc dashboardBloc;
  final List<TodoModel> listTodo;

  @override
  State<AppCard> createState() => _AppCardState();
}

class _AppCardState extends State<AppCard> {
  var items = ['PENDING', 'COMPLETED'];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final todo = widget.listTodo[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              widget.dashboardBloc.isHideFab.add(true);
              showBottomSheet(
                  enableDrag: false,
                  context: context,
                  builder: (context) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(todo.title ?? "",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25)),
                                ),
                                IconButton(
                                    onPressed: () {
                                      widget.dashboardBloc.isHideFab.add(false);
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(Icons.cancel_outlined))
                              ],
                            ),
                            Text(todo.description ?? "",
                                style: const TextStyle(fontSize: 20)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                    onPressed: () {},
                                    child: const Text(
                                      'COMPLETED',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    )),
                                TextButton(
                                  onPressed: () {
                                    widget.dashboardBloc
                                        .delete(todo.id!)
                                        .then((value) {
                                      widget.dashboardBloc.fetchData();
                                      Navigator.pop(context);
                                    });
                                  },
                                  child: const Text(
                                    'DELETE',
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ));
            },
            child: Card(
              color: todo.status!.toUpperCase() == "COMPLETED"
                  ? Colors.greenAccent.shade100
                  : Colors.deepOrange.shade100,
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(todo.title ?? "",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20)),
                            const SizedBox(height: 10),
                            Text(
                              todo.description ?? "",
                              style: const TextStyle(fontSize: 15),
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () async {
                                widget.dashboardBloc
                                    .updateDB(todo.id!, todo)
                                    .then((value) {
                                  widget.dashboardBloc.fetchData();
                                });
                                final refresh = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        AddScreen(todoModal: todo),
                                  ),
                                );
                                if (refresh == true) {
                                  widget.dashboardBloc.fetchData();
                                }
                              },
                              icon: const Icon(Icons.edit)),
                          IconButton(
                              onPressed: () {
                                widget.dashboardBloc
                                    .delete(todo.id!)
                                    .then((value) {
                                  widget.dashboardBloc.fetchData();
                                });
                              },
                              icon: const Icon(Icons.delete)),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Status : ',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Container(
                        height: 30,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.green),
                            borderRadius: BorderRadius.circular(10)),
                        child: DropdownButton(
                          items: items.map((value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            final request = TodoModel(
                                title: todo.title,
                                description: todo.description,
                                dueDate: todo.dueDate,
                                createdAt: todo.createdAt,
                                id: todo.id,
                                status: newValue);
                            widget.dashboardBloc
                                .updateDB(todo.id!, request)
                                .then((value) {
                              widget.dashboardBloc.fetchData();
                            });
                          },
                          value: todo.status!.toUpperCase(),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Text('Due Date : ${todo.dueDate}',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider(
          color: Colors.black,
        );
      },
      itemCount: widget.listTodo.length,
    );
  }
}
