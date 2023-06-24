class TrainingModel{
  final String section;
  final String id;
  final String? title;
  final String? discription;
  TrainingModel(
    this.section,
    this.id,
    this.title,
    this.discription
  );
}

class TrainingFormModel {
  final String user_id;
  final TrainingModel training;
  final String code;

  TrainingFormModel(
    this.user_id,
    this.training,
    this.code,
  );
}
