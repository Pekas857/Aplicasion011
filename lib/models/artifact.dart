class Artifact {
  final String civilization;
  final String civilizationSubtitle;
  final String name;
  final String description;
  final String date;
  final String iconAsset;
  final ArtifactCategory category;

  const Artifact({
    required this.civilization,
    this.civilizationSubtitle = '',
    required this.name,
    required this.description,
    this.date = '',
    this.iconAsset = '',
    required this.category,
  });
}

enum ArtifactCategory {
  maya,
  mexica,
  inca,
  olmeca,
}

// Sample data
final List<Artifact> sampleArtifacts = [
  const Artifact(
    civilization: 'MAYA',
    name: 'Máscara de Jade de Pakal',
    description: 'Impresionante máscara funeraria...',
    date: '683 d.C.',
    category: ArtifactCategory.maya,
  ),
  const Artifact(
    civilization: 'MEXICA (AZTECA)',
    name: 'Piedra del Sol',
    description: 'Monolito basáltico colosal...',
    category: ArtifactCategory.mexica,
  ),
  const Artifact(
    civilization: 'INCA / CHIMÚ',
    name: 'Tumi Ceremonial',
    description: 'Cuchillo ceremonial de oro sólido...',
    category: ArtifactCategory.inca,
  ),
  const Artifact(
    civilization: 'OLMECA',
    name: 'Cabeza Colosal No. 1',
    description: 'Escultura monumental de basalto...',
    category: ArtifactCategory.olmeca,
  ),
];

// Featured piece data
final Artifact featuredArtifact = const Artifact(
  civilization: 'MAYA',
  name: 'Máscara de Jade\nde Pakal',
  description: 'Máscara funeraria del rey K\'inich Janaab\' Pakal — Palenque, Chiapas.',
  date: '683 d.C.',
  category: ArtifactCategory.maya,
);
