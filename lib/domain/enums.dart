/// Estados por los que pasa una orden de reparación.
enum EstadoOrden {
  recibida('Recibida'),
  enReparacion('En reparación'),
  lista('Lista'),
  entregada('Entregada'),
  cancelada('Cancelada');

  const EstadoOrden(this.etiqueta);
  final String etiqueta;

  /// Estados en los que la orden sigue "viva" en el taller.
  static const List<EstadoOrden> abiertas = [
    EstadoOrden.recibida,
    EstadoOrden.enReparacion,
    EstadoOrden.lista,
  ];

  bool get esAbierta => abiertas.contains(this);

  /// Flujo permitido de estados (máquina de estados simple).
  List<EstadoOrden> get siguientes => switch (this) {
        EstadoOrden.recibida => [EstadoOrden.cancelada],
        EstadoOrden.enReparacion => [EstadoOrden.lista, EstadoOrden.cancelada],
        EstadoOrden.lista => [
            EstadoOrden.entregada,
            EstadoOrden.enReparacion,
            EstadoOrden.cancelada,
          ],
        EstadoOrden.entregada || EstadoOrden.cancelada => <EstadoOrden>[],
      };
}

enum TipoEquipo {
  celular('Celular'),
  tablet('Tablet'),
  laptop('Laptop');

  const TipoEquipo(this.etiqueta);
  final String etiqueta;
}
