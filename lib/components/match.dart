import 'package:flame/components.dart';

enum MatchStatus {
  initial,
  started,
  finished,
}

class Match extends Component {
  double seconds = 60;
  MatchStatus status = MatchStatus.initial;

  Match.empty();
  Match(this.seconds);

  void start() {
    status = MatchStatus.started;
  }

  void finish() {
    status = MatchStatus.finished;
    seconds = 60;
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (seconds <= 0) {
      finish();
    }

    if (status == MatchStatus.started) {
      seconds -= dt;
    }
  }
}
