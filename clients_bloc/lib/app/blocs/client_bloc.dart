import 'dart:async';

import 'package:clients_bloc/app/blocs/client_event.dart';
import 'package:clients_bloc/app/blocs/client_states.dart';
import 'package:clients_bloc/app/models/client_model.dart';
import 'package:clients_bloc/app/repositories/clients_repository.dart';

class ClientBloc {
  final clientRepo = ClientsRepository();

  final StreamController<ClientEvent> _inputClientController = StreamController<ClientEvent>();
  final StreamController<ClientState> _outputClientController = StreamController<ClientState>();

  Sink<ClientEvent> get inputClient => _inputClientController.sink;
  Stream<ClientState> get stream => _outputClientController.stream;

  ClientBloc(){
    _inputClientController.stream.listen(_mapEventToState);
  }

  _mapEventToState(ClientEvent event) async{
    List<Client> clients = [];

    if(event is LoadClientEvent){
      clients = clientRepo.loadClients();
    } else if(event is AddClientEvent){
      clients = clientRepo.addClient(event.client);
    }else if(event is RemoveClientEvent){
      clients = clientRepo.removeClient(event.client);
    }

    _outputClientController.add(ClientSuccessState(clients: clients));
  }
}