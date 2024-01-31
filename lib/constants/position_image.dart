class PositionImageAssets {
  static final PositionImageAssets _instance = PositionImageAssets._internal();

  factory PositionImageAssets() {
    return _instance;
  }

  PositionImageAssets._internal();

  static const String cameraMan = 'assets/images/position/p_camera_man.png';
  static const String itTechnician =
      'assets/images/position/p_it_technician.png';
  static const String digitalMarketing =
      'assets/images/position/p_digital_marketing.png';
  static const String sale = 'assets/images/position/p_sale.png';
  static const String softwareDeveloper =
      'assets/images/position/p_software_developer.png';
  static const String technicalSupport =
      'assets/images/position/p_technical_support.png';
  static const String technician = 'assets/images/position/p_technician.png';
  static const String videoEditor = 'assets/images/position/p_video_editor.png';

  static const List<String> positionList = [
    cameraMan,
    itTechnician,
    digitalMarketing,
    sale,
    softwareDeveloper,
    technicalSupport,
    technician,
    videoEditor,
  ];
}
