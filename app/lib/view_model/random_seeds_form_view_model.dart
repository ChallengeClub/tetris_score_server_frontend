import 'package:state_notifier/state_notifier.dart';

import 'package:fixnum/fixnum.dart' as $fixnum;

class RandomSeedsFormModel {
    final bool _isEnabledSeedConfiguration;
    final List<$fixnum.Int64> _seeds;

    RandomSeedsFormModel(
        this._isEnabledSeedConfiguration,
        this._seeds,
    );

    List<$fixnum.Int64> get seeds => _isEnabledSeedConfiguration ? _seeds : [];
    bool get isEnabledSeedConfiguration => _isEnabledSeedConfiguration;
}

class RandomSeedsFormStateNotifier extends StateNotifier<RandomSeedsFormModel> {
    RandomSeedsFormStateNotifier() : super(RandomSeedsFormModel(false, [])){
    }
    void toggleIsEnabled(bool? _){
        state = RandomSeedsFormModel(
            !state.isEnabledSeedConfiguration,
            state.seeds,
        );
    }

    void addSeed($fixnum.Int64 _seed) {
        state = RandomSeedsFormModel(
            state.isEnabledSeedConfiguration,
            [...state.seeds, _seed]
        );
    }

    void removeSeedAt(int _index) {
        int i = 0;
        List<$fixnum.Int64> new_seeds = [];
        for (final $fixnum.Int64 _seed in state.seeds){
            if (i != _index){
                new_seeds.add(_seed);
            }
            i++;
        }
        state = RandomSeedsFormModel(
            state.isEnabledSeedConfiguration,
            new_seeds,
        );
    }
}