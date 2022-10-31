import 'package:flutter_test/flutter_test.dart';

import '../../lib/model/form_model.dart';
import '../../lib/repository/form_repository.dart';

void main() {
    group("form_repository_tests", (){
        test('default test', () async {
            final FormModel _form = FormModel(
                "seigot", 
                "tetris", 
                "master",
                1000,
                1,
                "default",
                180,
                200,
                "",
                10
            );

            final FormRepository _formRepository = FormRepositoryImpl();
            bool res = await _formRepository.checkExistBranch(_form);
            expect(res, isTrue);
        });
        test('unexist repository test', () async {
            final FormModel _form = FormModel(
                "seigot", 
                "tetrisss", 
                "master",
                1000,
                1,
                "default",
                180,
                200,
                "",
                10
            );

            final FormRepository _formRepository = FormRepositoryImpl();
            bool res = await _formRepository.checkExistBranch(_form);
            expect(res, isFalse);
        });
        test('unexist branch test', () async {
            final FormModel _form = FormModel(
                "seigot", 
                "tetris", 
                "masterrr",
                1000,
                1,
                "default",
                180,
                200,
                "",
                10
            );

            final FormRepository _formRepository = FormRepositoryImpl();
            bool res = await _formRepository.checkExistBranch(_form);
            expect(res, isFalse);
        });
    });
}
