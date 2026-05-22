enum ArtifactCategory {
  maya,
  mexica,
  olmeca,
  pinturasRupestres,
  piramides,
}

class Artifact {
  final String civilization;
  final String civilizationSubtitle;
  final String name;
  final String description;
  final String date;
  final String iconAsset;
  final ArtifactCategory category;
  final String historyText;
  final String discoveryText;
  final String period;
  final String discovered;
  final String previewModel;
  
  // Modelos AR específicos para cada artefacto
  final List<String> arModels; // [modelo_restaurado, modelo_original]
  final List<String> arModelLabels; // Etiquetas para cada modelo

  const Artifact({
    required this.civilization,
    this.civilizationSubtitle = '',
    required this.name,
    required this.description,
    this.date = '',
    this.iconAsset = '',
    required this.category,
    this.historyText = '',
    this.discoveryText = '',
    this.period = '',
    this.discovered = '',
    this.previewModel = '',
    this.arModels = const [],
    this.arModelLabels = const [],
  });
}

// Datos de ejemplo con modelos AR específicos
final List<Artifact> sampleArtifacts = [
  const Artifact(
    civilization: 'MAYA',
    name: 'Máscara de Jade de Pakal',
    description: 'Impresionante máscara funeraria de jade encontrada en Palenque',
    date: '683 d.C.',
    category: ArtifactCategory.maya,
    period: 'Período Clásico (603 – 683 d.C.)',
    discovered: 'Descubierto en 1952',
    previewModel: 'assets/models/mascara_pakal.glb',
    arModels: [
      'assets/models/mascara_pakal_restaurada.glb',
      'assets/models/mascara_pakal.glb',
    ],
    arModelLabels: ['Restaurada', 'Original'],
    historyText:
        'Encontrada en el Templo de las Inscripciones en Palenque, México. '
        'Esta icónica máscara está hecha de 340 teselas de jade verde imperial, '
        'dos placas de concha para los ojos y obsidiana pulida para las pupilas. '
        'Representa el rostro reconstruido del rey para su viaje al inframundo '
        'mesoamericano (Xibalbá), simbolizando la renovación y la inmortalidad '
        'como el Dios del Maíz. Al escanearla, la tecnología holográfica la '
        'restaura digitalmente mostrando el brillo original de sus joyas precolombinas.',
    discoveryText:
        'Descubierta el 15 de junio de 1952 por el arqueólogo mexicano '
        'Alberto Ruz Lhuillier en la cripta funeraria del Templo de las '
        'Inscripciones en Palenque, Chiapas. Fue uno de los hallazgos más '
        'importantes de la arqueología mesoamericana, revelando que las '
        'pirámides mayas también servían como tumbas reales.',
  ),
  const Artifact(
    civilization: 'OLMECA',
    name: 'Cabeza Colosal No. 1',
    description: 'Escultura monumental de basalto de la cultura olmeca',
    date: '1200 a.C.',
    category: ArtifactCategory.olmeca,
    period: 'Período Preclásico (1200 – 900 a.C.)',
    discovered: 'Descubierto en 1862',
    previewModel: 'assets/models/cabeza.glb',
    arModels: [
      'assets/models/olmeca_antes.glb',
      'assets/models/olmeca_actual.glb',
    ],
    arModelLabels: ['Restaurada', 'Original'],
    historyText:
        'Las Cabezas Colosales olmecas son monumentales esculturas de basalto '
        'que representan rostros humanos con rasgos individualizados. La Cabeza '
        'Colosal No. 1 fue descubierta en San Lorenzo Tenochtitlán, Veracruz. '
        'Mide aproximadamente 2.85 metros de altura y pesa alrededor de 25 '
        'toneladas. Se cree que representan a gobernantes olmecas.',
    discoveryText:
        'La Cabeza Colosal No. 1 fue descubierta en 1862 por el viajero '
        'José María Melgar y Serrano en la hacienda de Hueyapan, en el '
        'municipio de Texistepec, Veracruz. Las investigaciones posteriores '
        'de Matthew Stirling en 1938-1946 revelaron la importancia de la '
        'civilización olmeca como la cultura madre de Mesoamérica.',
    ),
    const Artifact(
    civilization: 'Olmeca',
    name: 'Máscara del Sol',
    description:
        'Máscara ritual olmeca asociada al simbolismo solar y al poder religioso.',
    date: '900 a.C.',
    category: ArtifactCategory.olmeca,
    period: 'Período Preclásico Medio (1200 – 900 a.C.)',
    discovered:
        'Hallazgos arqueológicos en la región del Golfo de México',
    previewModel: 'assets/models/mascara_sol.glb',
    arModels: [
      'assets/models/mascara_solActual.glb',
      'assets/models/mascara_solAntes.glb',
    ],
    arModelLabels: ['Reconstruida', 'Original'],
    historyText:
        'Las máscaras olmecas son piezas rituales elaboradas principalmente en '
        'jade, serpentina o piedra, y están asociadas al culto solar, la élite '
        'gobernante y ceremonias religiosas. La Máscara del Sol representa '
        'la conexión entre el poder político y el orden cósmico, un concepto '
        'fundamental en la cosmovisión olmeca.',
    discoveryText:
        'Estas máscaras han sido encontradas en contextos ceremoniales y ofrendas '
        'en sitios como San Lorenzo y La Venta. Su función no siempre fue funeraria; '
        'en muchos casos se usaban como símbolos de autoridad y objetos sagrados '
        'relacionados con el sol y la fertilidad.',
  ),
  const Artifact(
    civilization: 'Mexica',
    name: 'Templo Mayor',
    description: 'Principal templo ceremonial de Tenochtitlan',
    date: '1325 d.C.',
    category: ArtifactCategory.piramides,
    period: 'Período Posclásico Tardío (1325 – 1521 d.C.)',
    discovered: 'Redescubierto arqueológicamente en 1978',
    previewModel: 'assets/models/templo_mayorActual.glb',
    arModels: [
      'assets/models/templo_mayorActual.glb',
      'assets/models/templo_mayorRestaurado.glb',
    ],
    arModelLabels: ['Reconstruido', 'Actual'],
    historyText:
        'El Templo Mayor fue el centro religioso y político de la ciudad mexica '
        'de Tenochtitlan. La estructura fue ampliada en varias etapas constructivas '
        'y simbolizaba la montaña sagrada donde habitaban los dioses.',
    discoveryText:
        'Tras la conquista española, el templo fue destruido. En 1978, el hallazgo '
        'del monolito de Coyolxauhqui permitió iniciar excavaciones que revelaron '
        'los restos que hoy se pueden visitar.',
  ),
  const Artifact(
    civilization: 'Maya',
    name: 'Pirámide de Kukulkán',
    description: 'Pirámide ceremonial maya en Chichén Itzá',
    date: '900 d.C.',
    category: ArtifactCategory.piramides,
    period: 'Período Posclásico Temprano (900 – 1200 d.C.)',
    discovered: 'Redescubierta en el siglo XIX',
    previewModel: 'assets/models/kukulkanAntes.glb',
    arModels: [
      'assets/models/kukulkanAntes.glb',
      'assets/models/kukulkanActual.glb',
    ],
    arModelLabels: ['Reconstruida', 'Actual'],
    historyText:
        'La Pirámide de Kukulkán, también conocida como El Castillo, es una de las '
        'estructuras más representativas de la civilización maya. Cuenta con cuatro '
        'escalinatas de 91 escalones cada una, que suman 365 días del año solar.',
    discoveryText:
        'Durante los equinoccios se proyecta una sombra en forma de serpiente que '
        'desciende por la escalinata, simbolizando el descenso del dios Kukulkán.',
  ),
];

final Artifact featuredArtifact = sampleArtifacts[0];