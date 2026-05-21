class PinturaRupestre {

  final String nombre;
  final String anio;
  final String descripcion;
  final String ubicacion;

  const PinturaRupestre({
    required this.nombre,
    required this.anio,
    required this.descripcion,
    required this.ubicacion,
  });

}
final List<PinturaRupestre> pinturasRupestres = [

  const PinturaRupestre(
    nombre: 'Cueva de San Borjitas',
    anio: '7,500 .',
    ubicacion: 'Sierra de Guadalupe, Baja California Sur, México',
    descripcion:
        'El mural principal, de unos 50m de frente, muestra figuras antropomorfas (algunas con flechas), chamanes y animales.',
  ),

  const PinturaRupestre(
    nombre: 'Cueva del Tecolote y el Venado' ,
    anio: '500',
    ubicacion: 'Chihuahua, México',
    descripcion:
        'Estas pinturas retratan diversas escenas de al menos tres grupos de cazadores y recolectores que habitaron la zona norte del país durante la época prehispánica.'),

];