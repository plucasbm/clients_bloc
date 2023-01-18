import 'dart:math';

import 'package:clients_bloc/app/blocs/client_bloc.dart';
import 'package:clients_bloc/app/blocs/client_event.dart';
import 'package:clients_bloc/app/blocs/client_states.dart';
import 'package:clients_bloc/app/models/client_model.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final ClientBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = ClientBloc();
    bloc.inputClient.add(LoadClientEvent());
  }

  @override
  void dispose() {
    bloc.inputClient.close();
    super.dispose();
  }

  String randomName() {
    final rand = Random();

    return ['Francisco', 'Joana', 'Samira', 'Camilla', 'Sett']
        .elementAt(rand.nextInt(4));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clientes'),
        actions: [
          IconButton(
            onPressed: () {
              bloc.inputClient.add(
                AddClientEvent(client: Client(name: randomName())),
              );
            },
            icon: const Icon(Icons.add_outlined),
          ),
        ],
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: StreamBuilder<ClientState>(
          stream: bloc.stream,
          builder: (context, snapshot) {
            final clientsList = snapshot.data?.clients ?? [];
            return ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    child: ClipRRect(
                      child: Text(clientsList[index].name.substring(0,1)),
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  title: Text(clientsList[index].name),
                  trailing: IconButton(
                      onPressed: () {
                        bloc.inputClient.add(
                          RemoveClientEvent(client: clientsList[index]),
                        );
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      )),
                );
              },
              separatorBuilder: (_, __) => const Divider(),
              itemCount: clientsList.length,
            );
          }
        ),
      ),
    );
  }
}
