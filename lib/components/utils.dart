double boosts(double origin, double rate) {
  var n = (origin * rate).ceil() % 2 == 1;
  var b = origin * rate % 1;
  return n ? 1 - b : b;
}
