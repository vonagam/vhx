package vhx.iter.impl;


class RangeIterable {

  final start: Int;

  final end: Int;


  public inline function new( start: Int, end: Int ) {

    this.start = start;

    this.end = end;

  }


  public inline function iterator()

    return new RangeIterator( start, end );

}


class RangeIterator {

  final end: Int;

  final step: Int;

  var value: Int;


  public inline function new( start: Int, end: Int ) {

    this.end = end;

    this.step = end == start ? 0 : end > start ? 1 : -1;

    this.value = start - this.step;

  }


  public inline function hasNext()

    return value + step != end;

  public inline function next()

    return value += step;

}
