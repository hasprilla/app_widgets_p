import 'package:app_widgets_p/ahorros/ahorros_screen.dart';
import 'package:app_widgets_p/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'ahorros/model/ahorros_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Widgets',
      theme: AppTheme().getTheme(),
      home: const NavigationWidget(),
    );
  }
}

class NavigationWidget extends StatelessWidget {
  const NavigationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navegación Simple'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navegar a la tercera pantalla
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyHome()),
                );
              },
              child: const Text('Ver ahorros'),
            ),
          ],
        ),
      ),
    );
  }
}

class MyHome extends StatelessWidget {
  const MyHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Productos>>(
      stream: ProductosService().productosStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No hay productos disponibles');
        }

        final List<AhorroModel> ahorros = snapshot.data!.map((producto) {
          return AhorroModel(
            id: producto.codigo ?? 0,
            nombre: producto.nombreCompleto.toString(),
            monto: producto.precio?.toDouble() ?? 0.0,
            icono: 'account_balance_rounded',
            fechaCreacion: DateTime.now(),
          );
        }).toList();

        return AhorrosScreen(
          ahorros: ahorros,
        );
      },
    );
  }
}

class ProductosService {
  // Stream con lista fija de productos
  final BehaviorSubject<List<Productos>> _productosStream =
      BehaviorSubject<List<Productos>>.seeded([
    Productos(codigo: 1, nombreCompleto: "Laptop", precio: 1200),
    Productos(codigo: 2, nombreCompleto: "Mouse", precio: 25),
    Productos(codigo: 3, nombreCompleto: "Teclado", precio: 80),
    Productos(codigo: 4, nombreCompleto: "Monitor", precio: 300),
    Productos(codigo: 5, nombreCompleto: "Auriculares", precio: 150),
    Productos(codigo: 6, nombreCompleto: "Tablet", precio: 450),
    Productos(codigo: 7, nombreCompleto: "Smartphone", precio: 800),
    Productos(codigo: 8, nombreCompleto: "Impresora", precio: 200),
    Productos(codigo: 9, nombreCompleto: "Escáner", precio: 150),
    Productos(codigo: 10, nombreCompleto: "Router WiFi", precio: 75),
  ]);

  Stream<List<Productos>> get productosStream => _productosStream.stream;

  void agregarProducto(Productos producto) {
    final currentList = _productosStream.value;
    _productosStream.add([...currentList, producto]);
  }

  void dispose() {
    _productosStream.close();
  }
}

class Productos {
  int? codigo;
  String? nombreCompleto;
  int? precio;

  Productos({
    this.codigo,
    this.nombreCompleto,
    this.precio,
  });
}
