import 'dart:typed_data';

class TrainingModel{
  final String section;
  final String id;
  final String? title;
  final String? description;
  final String? constraints;
  final String? inputTemplate;
  final String? inputDescription;
  final String? inputSample;
  final String? outputTemplate;
  final String? outputDescription;
  final String? outputSample;
  final String? sampleDescription;
  final String? inputSample2;
  final String? outputSample2;
  final String? sampleDescription2;
  final String? answerExample;
  final String? initialFormValue;

  TrainingModel(
    this.section,
    this.id,
    this.title,
    this.description,
    this.constraints,
    this.inputTemplate,
    this.inputDescription,
    this.inputSample,
    this.outputTemplate,
    this.outputDescription,
    this.outputSample,
    this.sampleDescription,
    this.inputSample2,
    this.outputSample2,
    this.sampleDescription2,
    this.answerExample,
    this.initialFormValue,
  );

  TrainingModel.fromJson(dynamic map)
  : section = map['Section'],
    id = map["Id"].toString(),
    title = map['Title'],
    description = map['Description'],
    constraints = map['Constraints'],
    inputTemplate = map['InputTemplate'],
    inputDescription = map['InputDescription'],
    inputSample = map['InputSample'],
    outputTemplate = map['OutputTemplate'],
    outputDescription = map['OutputDescription'],
    outputSample = map['OutputSample'],
    sampleDescription = map['SampleDescription'],
    inputSample2 = map['InputSample2'],
    outputSample2 = map['OutputSample2'],
    sampleDescription2 = map['SampleDescription2'],
    answerExample = map['AnswerExample'],
    initialFormValue = map['InitialFormValue'];  

  @override
  bool operator == (Object other) =>
    identical(other, this) || other is TrainingModel && id == other.id && section == other.section;
    
  @override
  int get hashCode => Object.hashAll([section, id]);

  String get section_id => "${section}-${id}";
}

class TrainingFormModel {
  final TrainingModel training;
  final String status;
  final String? error_message;
  final List<String>? results;
  final Uint8List? image_byte;
  
  TrainingFormModel(
    this.training,
    this.status,
    this.error_message,
    this.results,
    this.image_byte,
  );

  TrainingFormModel copyWith({TrainingModel? training, String? status, String? error_message, List<String>? results, Uint8List? image_byte}){
    return TrainingFormModel(
      training ?? this.training,
      status ?? this.status,
      error_message ?? this.error_message,
      results ?? this.results,
      image_byte ?? this.image_byte,
    );
  }
}
