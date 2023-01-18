import 'package:clients_bloc/app/models/client_model.dart';

class ClientsRepository {
  final List<Client> _clients = [];

  List<Client> loadClients() {
    _clients.addAll(
      [
        Client(name: 'Paulo Lucas'),
        Client(name: 'Paulo Vitor'),
        Client(name: 'Paulo Vinícius'),
        Client(name: 'Paulo Sérgio'),
        Client(name: 'Dôra Barros'),
      ],
    );
    return _clients;
  }

  List<Client> addClient(Client client){
    _clients.add(client);
    return _clients;
  }

  List<Client> removeClient(Client client){
    _clients.remove(client);
    return _clients;
  }
}